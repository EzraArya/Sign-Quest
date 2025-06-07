//
//  SQChangePasswordViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import Combine
import FirebaseAuth

@MainActor
class SQChangePasswordViewModel: ObservableObject {
    @Published public var oldPassword: String = ""
    @Published public var newPassword: String = ""
    @Published public var confirmPassword: String = ""
    
    @Published public var errorMessage: String = ""
    
    private var coordinator: SQProfileCoordinator?
    private var networkService: SQProfileNetworkServiceProtocol
    
    init(networkService: SQProfileNetworkServiceProtocol = SQProfileNetworkService()) {
        self.networkService = networkService
    }
    
    func setCoordinator(_ coordinator: SQProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    private func validateInput() -> Bool {        
        guard !oldPassword.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All password fields are required."
            return false
        }
        
        guard newPassword.count >= 6 else {
            errorMessage = "Your new password must be at least 6 characters long."
            return false
        }
        
        guard newPassword == confirmPassword else {
            errorMessage = "Your new and confirmation passwords do not match."
            return false
        }
        
        return true
    }
    
    @MainActor
    func changePassword() {
        guard validateInput() else { return }
        guard let user = Auth.auth().currentUser, let email = user.email else {
            errorMessage = "Could not find an active user session."
            return
        }
        
        Task.detached { [weak self] in
            do {
                let credential = await EmailAuthProvider.credential(withEmail: email, password: self?.oldPassword ?? "")
                
                _ = try await user.reauthenticate(with: credential)
                try await self?.networkService.updatePassword(password: self?.newPassword ?? "")
                
                await MainActor.run { [weak self] in
                    guard let self = self else { return }
                    self.coordinator?.pop()
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self = self else { return }
                    self.errorMessage = "Failed to update password: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func navigateBack() {
        coordinator?.pop()
    }
}
