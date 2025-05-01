//
//  SQChangePasswordViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import Combine

class SQChangePasswordViewModel: ObservableObject {
    @Published public var oldPassword: String = ""
    @Published public var newPassword: String = ""
    @Published public var confirmPassword: String = ""
    private var coordinator: SQProfileCoordinator?
    
    func setCoordinator(_ coordinator: SQProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    func changePassword() {
        // MARK: Implement password change logic here
        coordinator?.pop()
    }
    
    func navigateBack() {
        coordinator?.pop()
    }
}
