//
//  SQProfileViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import SignQuestUI
import SignQuestCore

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



class SQProfileViewModel: ObservableObject {
    private var coordinator: SQProfileCoordinator?
    @Published public var email: String = "email@gmail.com"
    @Published public var joinDate: String = "9th December"
    @Published public var showDeleteAlert: Bool = false
    @Published public var overviewItems: [SQProfileOverview] = []
        
    init() {
        setupOverviewItems()
    }
        
    private func setupOverviewItems() {
        overviewItems = [
            SQProfileOverview(type: .totalScore, value: "50,000"),
            SQProfileOverview(type: .signLearned, value: "10"),
            SQProfileOverview(type: .dayStreak, value: "5"),
            SQProfileOverview(type: .levelCompleted, value: "2")
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
