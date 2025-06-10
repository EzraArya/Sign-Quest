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
import Combine

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
    @Published public var showDeleteAlert: Bool = false
    @Published public var overviewItems: [SQProfileOverview] = []
    @Published public var isLoading: Bool = true
    
    private var userManager: UserManager?
    private var coordinator: SQProfileCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupPlaceholderItems()
    }
    
    func link(userManager: UserManager, coordinator: SQProfileCoordinator) {
        self.userManager = userManager
        self.coordinator = coordinator
        setupUserSubscription()
    }
    
    private func setupPlaceholderItems() {
        overviewItems = [
            SQProfileOverview(type: .totalScore, value: "0000"),
            SQProfileOverview(type: .signLearned, value: "000"),
            SQProfileOverview(type: .dayStreak, value: "00"),
            SQProfileOverview(type: .levelCompleted, value: "00")
        ]
    }
    
    private func setupUserSubscription() {
        guard let userManager = userManager else { return }
        
        Publishers.CombineLatest(userManager.$authUser, userManager.$firestoreUser)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] authUser, firestoreUser in
                guard let self = self else { return }
                
                self.isLoading = authUser != nil && firestoreUser == nil
                
                if let user = firestoreUser {
                    self.setupOverviewItems(for: user)
                } else {
                    self.setupPlaceholderItems()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupOverviewItems(for user: SQUser?) {
        let signLearnedValue: String = {
            if let currentLevelString = user?.currentLevel, let currentLevel = Int(currentLevelString) {
                return String(currentLevel * 5)
            }
            return "0"
        }()
        
        overviewItems = [
            SQProfileOverview(type: .totalScore, value: String(user?.totalScore ?? 0)),
            SQProfileOverview(type: .signLearned, value: signLearnedValue),
            SQProfileOverview(type: .dayStreak, value: "5"),
            SQProfileOverview(type: .levelCompleted, value: "\(user?.currentLevel ?? "0")")
        ]
    }
    
    func logout() {
        userManager?.signOut()
    }
    
    func navigateToEditProfile() {
        coordinator?.push(.editProfile)
    }
    
    func navigateToEditProfilePicture() {
        coordinator?.push(.editProfilePicture)
    }
    
    func deleteAccount() {
        showDeleteAlert = false
        coordinator?.navigateToWelcome()
    }
}

extension SQProfileViewModel {
    var userName: String {
        return userManager?.firestoreUser?.fullName ?? "User Name"
    }
    
    var userEmail: String {
        return userManager?.firestoreUser?.email ?? "email@gmail.com"
    }
    
    var joinDate: String {
        if let date = userManager?.firestoreUser?.createdAt {
            return date.formatted(date: .long, time: .omitted)
        } else {
            return "Joined Date"
        }
    }
    
    var profilePicture: String? {
        return userManager?.firestoreUser?.image
    }
}
