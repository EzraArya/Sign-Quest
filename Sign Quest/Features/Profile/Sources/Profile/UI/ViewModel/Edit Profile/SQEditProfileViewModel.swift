//
//  SQEditProfileViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SignQuestCore
import Combine

class SQEditProfileViewModel: ObservableObject {
    @Published public var firstName: String = ""
    @Published public var lastName: String = ""
    @Published public var email: String = ""
    @Published public var password: String = ""
    private var coordinator: SQProfileCoordinator?
    
    func setCoordinator(_ coordinator: SQProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    func updateProfile() {
        // Implement the logic to update the profile here
        coordinator?.pop()
    }
    
    func navigateToChangePassword() {
        coordinator?.push(.editPassword)
    }
    
    func navigateBack() {
        coordinator?.pop()
    }
}
