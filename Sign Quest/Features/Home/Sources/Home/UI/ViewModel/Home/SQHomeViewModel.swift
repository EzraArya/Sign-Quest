//
//  SQHomeViewModel.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import Combine
import FirebaseFirestore
import SignQuestModels
import SignQuestUI
import SignQuestCore

struct ActivePopup {
    let sectionId: String
    let levelId: String
}

@MainActor
class SQHomeViewModel: ObservableObject {
    
    @Published public var sections: [SQSection] = []
    @Published var activePopup: ActivePopup? = nil
    @Published var isLoading: Bool = true
    
    private var levelsBySection: [String: [SQLevel]] = [:]
    private var userProgress: [String: SQUserLevelData] = [:]

    private var coordinator: SQHomeCoordinator?
    private var userManager: UserManager?
    private var networkService: SQHomeNetworkServiceProtocol
    private let db = Firestore.firestore()

    init(networkService: SQHomeNetworkServiceProtocol = SQHomeNetworkService()) {
        self.networkService = networkService
    }
    
    func link(_ coordinator: SQHomeCoordinator, userManager: UserManager) {
        self.coordinator = coordinator
        self.userManager = userManager
    }
    
    func loadContent() async {
        guard let userID = userManager?.firestoreUser?.id else { return }
        
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let sectionTask = networkService.fetchSections()
            async let levelTask = networkService.fetchLevels()
            async let progressTask = networkService.fetchUserLevelData(for: userID)
            
            let (fetchedSections, fetchedLevels, fetchedProgress) = try await (sectionTask, levelTask, progressTask)
            
            let finalProgress: [SQUserLevelData]
            let missingLevels = findMissingLevels(
                allLevels: fetchedLevels,
                existingProgress: fetchedProgress
            )
            
            if !missingLevels.isEmpty {
                try await initializeUserLevelData(for: userID, levels: missingLevels)
                finalProgress = try await networkService.fetchUserLevelData(for: userID)
            } else {
                finalProgress = fetchedProgress
            }
            
            await updateContentData(
                sections: fetchedSections,
                levels: fetchedLevels,
                progress: finalProgress
            )
        } catch {
            print("Error loading content: \(error.localizedDescription)")
        }
    }
    
    private func findMissingLevels(
        allLevels: [SQLevel],
        existingProgress: [SQUserLevelData]
    ) -> [SQLevel] {
        let progressLevelIds = Set(existingProgress.compactMap { $0.id })
        
        return allLevels.filter { level in
            guard let levelId = level.id else { return false }
            return !progressLevelIds.contains(levelId)
        }
    }
    
    private func updateContentData(
        sections: [SQSection],
        levels: [SQLevel],
        progress: [SQUserLevelData]
    ) async {
        self.sections = sections.sorted(by: { $0.number < $1.number })
        self.levelsBySection = Dictionary(grouping: levels, by: { $0.sectionId })
        self.userProgress = Dictionary(uniqueKeysWithValues: progress.compactMap { progressItem in
            guard let levelId = progressItem.id else { return nil }
            return (levelId, progressItem)
        })
    }

    func levels(for section: SQSection) -> [SQLevel] {
        guard let sectionId = section.id else { return [] }
        return (levelsBySection[sectionId] ?? []).sorted(by: { $0.number < $1.number })
    }
    
    func status(for level: SQLevel) -> SQUserLevelDataStatus {
        guard let levelId = level.id else { return .locked }
        if userProgress.isEmpty && level.number == 1 && sections.first?.id == level.sectionId {
            return .available
        }
        return userProgress[levelId]?.status ?? .locked
    }
    
    func bestScore(for level: SQLevel) -> Int? {
        guard let levelId = level.id else { return nil }
        return userProgress[levelId]?.bestScore
    }
    
    func getLevelButtonStyle(for level: SQLevel) -> SQLevelButtonStyle {
        switch self.status(for: level) {
        case .locked: return .locked
        case .available: return .default
        case .completed: return .completed
        }
    }
    
    func canNavigate(to level: SQLevel) -> Bool {
        return self.status(for: level) != .locked
    }
    
    func navigateToGame(for level: SQLevel) {
        if canNavigate(to: level) {
            coordinator?.navigateToGame()
        }
    }
    
    func initializeUserLevelData(for userId: String, levels: [SQLevel]) async throws {
        let levelDataItems = levels.enumerated().compactMap { index, level -> (String, SQUserLevelData)? in
            guard let levelId = level.id else { return nil }
            let initialData = SQUserLevelData(status: (index == 0) ? .available : .locked, bestScore: 0, lastAttempted: nil)
            return (levelId, initialData)
        }
        
        try await networkService.createUserLevelDataBatch(for: userId, levelDataItems: levelDataItems)
    }
}
