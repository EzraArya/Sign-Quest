//
//  SQWelcomeViewModel.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import Combine
import SignQuestCore

public class SQWelcomeViewModel: ObservableObject {
    @Published var title: String = "Already have an account?"
    @Published var subtitle: String = "New to SIBI Quest?"
    @Published var buttonTitle: String = "Sign In"
    @Published var buttonSubtitle: String = "Get Started"
    private var coordinator: SQOnboardingCoordinator?
    
    public init() {}
    
    public func setCoordinator(_ coordinator: SQOnboardingCoordinator) {
        self.coordinator = coordinator
    }
    
    public func navigateToIntroduction() {
        UserDefaultsManager.shared.isOnboardingCompleted = true
        coordinator?.push(.introduction)
    }
    
    @MainActor
    public func navigateToAuthentication() {
        coordinator?.showAuthentication(isLogin: true)
    }
}
