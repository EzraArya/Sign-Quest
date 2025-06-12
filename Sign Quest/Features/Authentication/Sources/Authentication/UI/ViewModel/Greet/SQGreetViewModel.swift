//
//  SQGreetViewModel.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import SignQuestCore

class SQGreetViewModel: ObservableObject {
    private var coordinator: SQAuthenticationCoordinator?
    private var userDefaultManager: UserDefaultsManager = UserDefaultsManager.shared
    
    func setCoordinator(_ coordinator: SQAuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func navigateToHome() {
        userDefaultManager.isOnboardingCompleted = true
        coordinator?.showMainFlow()
    }
}
