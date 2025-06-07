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
    
    private var networkService: SQAuthenticationNetworkServiceProtocol
    private var coordinator: SQAuthenticationCoordinator?
    private var user: SQUser = SQUser(firstName: "", lastName: "", email: "", age: 0)
    
    init(networkService: SQAuthenticationNetworkServiceProtocol = SQAuthenticationNetworkService()) {
        self.networkService = networkService
    }
    
    func setCoordinator(_ coordinator: SQAuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func createAccount() {
        self.user = SQUser(
            firstName: firstName,
            lastName: lastName,
            email: email,
            age: Int(age) ?? 0
        )
        
        Task {
            // This do-catch block is essential for debugging
            do {
                try await networkService.register(user: user, password: password)
                print("✅ Successfully created user and saved to Firestore.")
                coordinator?.push(.greet)
            } catch {
                // THIS WILL PRINT THE EXACT ERROR FROM FIREBASE
                print("❌ FAILED TO REGISTER: \(error.localizedDescription)")
                print("---")
                print("Full error details: \(error)")
            }
        }
    }
    
    @MainActor
    func navigateToOnboarding() {
        coordinator?.showOnboarding()
    }
}

extension SQRegisterViewModel {
    func incrementTabProgress() {
        self.currentTab += 1
        self.progressAmount += 25
    }
    
    func decrementTabProgress() {
        self.currentTab -= 1
        self.progressAmount -= 25
    }
}
