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
    private var networkService: SQHomeNetworkServiceProtocol
    private let db = Firestore.firestore()

    init(networkService: SQHomeNetworkServiceProtocol = SQHomeNetworkService()) {
        self.networkService = networkService
    }
    
    func setCoordinator(_ coordinator: SQHomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func loadContent(forUserID userID: String) async {
        isLoading = true
        do {
            let fetchedSections = try await networkService.fetchSections()
            let fetchedLevels = try await networkService.fetchLevels()
            let fetchedProgress = try await networkService.fetchUserLevelData(for: userID)
            
            self.sections = fetchedSections.sorted(by: { $0.number < $1.number })
            self.levelsBySection = Dictionary(grouping: fetchedLevels, by: { $0.sectionId })
            self.userProgress = Dictionary(uniqueKeysWithValues: fetchedProgress.compactMap {
                guard let levelId = $0.id else { return nil }
                return (levelId, $0)
            })
            
            isLoading = false
        } catch {
            print("Error loading content: \(error.localizedDescription)")
        }
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
}
