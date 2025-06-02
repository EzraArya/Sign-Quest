//
//  SQRegisterViewModel.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import SignQuestModels

class SQRegisterViewModel: ObservableObject {
    @Published public var currentTab = 0
    @Published public var age = ""
    @Published public var firstName = ""
    @Published public var lastName = ""
    @Published public var email = ""
    @Published public var password = ""
    @Published public var confirmPassword = ""
    @Published public var agePageValid = false
    @Published public var namePageValid = false
    @Published public var emailPageValid = false
    @Published public var passwordPageValid = false
    @Published public var progressAmount = 25.0
    private var coordinator: SQAuthenticationCoordinator?
    private var user: SQUser?
    
    func setCoordinator(_ coordinator: SQAuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func incrementProgress() {
        self.currentTab += 1
        self.progressAmount += 25
    }
    
    func decrementProgress() {
        self.currentTab -= 1
        self.progressAmount -= 25
    }
    
    func createAccount() {
        self.user = SQUser(
            firstName: self.firstName,
            lastName: self.lastName,
            email: self.email,
            age: Int(self.age) ?? 0,
            password: self.password
        )
        coordinator?.push(.greet)
    }
    
    @MainActor
    func navigateToOnboarding() {
        coordinator?.showOnboarding()
    }
}
