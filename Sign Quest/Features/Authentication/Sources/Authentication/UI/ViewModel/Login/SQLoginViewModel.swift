//
//  SQLoginViewModel.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import Combine
import SignQuestUI

public class SQLoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailStyle: SQTextFieldStyle = .default
    @Published var passwordStyle: SQTextFieldStyle = .default
    @Published var hasError: Bool = false
    private var coordinator: SQAuthenticationCoordinator?
    private var networkService: SQAuthenticationNetworkServiceProtocol
    
    init(networkService: SQAuthenticationNetworkServiceProtocol = SQAuthenticationNetworkService()) {
        self.networkService = networkService
    }

    func setCoordinator(_ coordinator: SQAuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    func validateEmail() -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedEmail.contains("@"),
              let atIndex = trimmedEmail.firstIndex(of: "@"),
              trimmedEmail.distance(from: atIndex, to: trimmedEmail.endIndex) > 1,
              !trimmedEmail.contains("..") else {
            return false
        }
        
        let emailRegex = #"^[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?@[A-Za-z0-9]([A-Za-z0-9-]{0,30}[A-Za-z0-9])?(\.[A-Za-z]{2,})+$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: trimmedEmail)
    }
    
    func validateInput(isEmailActive: Bool, isPasswordActive: Bool) {
        hasError = email.isEmpty || password.isEmpty
        emailStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isEmailActive, hasError: email.isEmpty)
        passwordStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isPasswordActive, hasError: password.isEmpty)
    }
    
    @MainActor
    func login() {
        Task {
            try await networkService.login(email: email, password: password)
            coordinator?.push(.greet)
        }
    }
    
    @MainActor
    func navigateBack() {
        coordinator?.showOnboarding()
    }
}
