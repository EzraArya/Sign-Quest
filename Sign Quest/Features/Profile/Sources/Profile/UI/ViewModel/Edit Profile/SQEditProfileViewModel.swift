//
//  SQEditProfileViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SignQuestCore
import Combine
import SignQuestModels

class SQEditProfileViewModel: ObservableObject {
    @Published public var firstName: String = ""
    @Published public var lastName: String = ""
    @Published public var email: String = ""
    @Published public var password: String = ""
    private var coordinator: SQProfileCoordinator?
    private let userId: String = "0" // Replace with actual user ID
    private let networkService: SQProfileNetworkService = SQProfileNetworkService()

    func setCoordinator(_ coordinator: SQProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func updateProfile() {
        // Implement the logic to update the profile here
        let updatedUser = SQUser(
            firstName: firstName,
            lastName: lastName,
            email: email,
            age: 12,
            password: ""
        )
        
        Task {
            await updateUserProfile(userId: userId, profile: updatedUser)
        }
        
        coordinator?.pop()
    }
    
    func navigateToChangePassword() {
        coordinator?.push(.editPassword)
    }
    
    func navigateBack() {
        coordinator?.pop()
    }
}

extension SQEditProfileViewModel {
    func updateUserProfile(userId: String, profile: SQUser) async {
        await networkService.updateProfile(
            userId: userId,
            profile: profile
        )
    }
}
