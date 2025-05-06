//
//  SQProfileViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import SignQuestUI
import SignQuestCore
import SignQuestModels

enum SQProfileOverviewType {
    case totalScore
    case signLearned
    case dayStreak
    case levelCompleted
    
    var image: String {
        switch self {
        case .totalScore:
            return "star"
        case .signLearned:
            return "hand.raised"
        case .dayStreak:
            return "flame"
        case .levelCompleted:
            return "medal"
        }
    }
    
    var imageColor: SQColor {
        switch self {
        case .totalScore:
            return .complementary
        case .signLearned:
            return .cream
        case .dayStreak:
            return .red
        case .levelCompleted:
            return .complementary
        }
    }
    
    var description: String {
        switch self {
        case .totalScore:
            return "Total Score"
        case .signLearned:
            return "Sign Learned"
        case .dayStreak:
            return "Day Streak"
        case .levelCompleted:
            return "Level Completed"
        }
    }
}
        
struct SQProfileOverview {
    let type: SQProfileOverviewType
    var value: String
}

@MainActor
class SQProfileViewModel: ObservableObject {
    private var coordinator: SQProfileCoordinator?
    @Published public var showDeleteAlert: Bool = false
    @Published public var overviewItems: [SQProfileOverview] = []
    public var user: SQUser?
    
    private let networkService: SQProfileNetworkService = SQProfileNetworkService()
    
    init() {
        loadUserProfile()
    }
    
    @MainActor
    private func loadUserProfile() {
        Task { @MainActor in
            await fetchUserProfile()
            setupOverviewItems()
        }
    }
        
    private func setupOverviewItems() {
        let signLearnedValue: String = {
            if let currentLevelString = self.user?.currentLevel,
               let currentLevel = Int(currentLevelString) {
                return String(currentLevel * 5)
            }
            return "0"
        }()
        
        overviewItems = [
            SQProfileOverview(type: .totalScore, value: String(self.user?.totalScore ?? 0)),
            SQProfileOverview(type: .signLearned, value: signLearnedValue),
            SQProfileOverview(type: .dayStreak, value: "5"),
            SQProfileOverview(type: .levelCompleted, value: "\(self.user?.currentLevel ?? "0")")
        ]
    }
    func setCoordinator(_ coordinator: SQProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    func navigateToEditProfile() {
        coordinator?.push(.editProfile)
    }
    
    @MainActor
    func logout() {
        UserDefaultsManager.shared.resetAll()
        coordinator?.navigateToWelcome()
    }
    
    @MainActor
    func deleteAccount() {
        UserDefaultsManager.shared.resetAll()
        coordinator?.navigateToWelcome()
    }
}

extension SQProfileViewModel {
    var userName: String {
        return user?.fullName ?? "User Name"
    }
    
    var userEmail: String {
        return user?.email ?? "email@gmail.com"
    }
    
    var joinDate: String {
        if let date = user?.createdAt {
            return date.formatted(date: .long, time: .omitted)
        } else {
            return Date().formatted(date: .long, time: .omitted)
        }
    }
    
    func fetchUserProfile() async {
        self.user = await networkService.fetchProfile(userId: "1")
    }
}
