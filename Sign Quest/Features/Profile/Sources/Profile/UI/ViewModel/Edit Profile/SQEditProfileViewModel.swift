//
//  SQEditProfileViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import Combine
import SignQuestCore
import SignQuestModels

@MainActor
class SQEditProfileViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var userManager: UserManager?
    private var coordinator: SQProfileCoordinator?
    private let networkService: SQProfileNetworkServiceProtocol
    
    init(networkService: SQProfileNetworkServiceProtocol = SQProfileNetworkService()) {
        self.networkService = networkService
    }
    
    func link(userManager: UserManager, coordinator: SQProfileCoordinator) {
        self.userManager = userManager
        self.coordinator = coordinator
        
        self.firstName = userManager.firestoreUser?.firstName ?? ""
        self.lastName = userManager.firestoreUser?.lastName ?? ""
        self.email = userManager.firestoreUser?.email ?? ""
    }

    func updateProfile() async {
        isLoading = true
        errorMessage = nil
        
        guard var updatedUser = userManager?.firestoreUser else {
            errorMessage = "Could not find user data to update."
            isLoading = false
            return
        }
        
        updatedUser.firstName = self.firstName
        updatedUser.lastName = self.lastName
        
        do {
            guard let userId = updatedUser.id else { return }
            try await networkService.updateProfile(userId: userId, profile: updatedUser)
            
            print("✅ Profile updated successfully.")
            isLoading = false
            coordinator?.pop()
            
        } catch {
            print("❌ Error updating profile: \(error.localizedDescription)")
            errorMessage = "Failed to update profile. Please try again."
            isLoading = false
        }
    }
    
    func navigateToChangePassword() {
        coordinator?.push(.editPassword)
    }
    
    func navigateBack() {
        coordinator?.pop()
    }
}
