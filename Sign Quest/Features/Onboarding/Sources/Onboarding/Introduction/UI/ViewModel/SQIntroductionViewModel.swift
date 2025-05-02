//
//  SQIntroductionViewModel.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestCore

struct IntroductionPage {
    let title: String
    let boldTitle: String
    let subtitle: String
}

class SQIntroductionViewModel: ObservableObject {
    @Published var pages: [IntroductionPage] = [
        IntroductionPage(title: "Welcome to", boldTitle: "Sign Quest", subtitle: "Your journey into sign language starts here."),
        IntroductionPage(title: "A Place to Learn", boldTitle: "SIBI", subtitle: "Practice signs, complete challenges, and track your progress."),
        IntroductionPage(title: "Ready to", boldTitle: "Start?", subtitle: "Create your account and begin your quest today.")
    ]
    private var coordinator: SQOnboardingCoordinator?
    @Published public var currentTab = 0
    
    public func setCoordinator(_ coordinator: SQOnboardingCoordinator) {
        self.coordinator = coordinator
    }
    
    @MainActor
    public func navigateToRegistration() {
        UserDefaultsManager.shared.isOnboardingCompleted = true
        coordinator?.showAuthentication(isLogin: false)
    }
    
    public func navigateBack() {
        coordinator?.pop()
    }
    
    public func incrementCurrentTab() {
        self.currentTab += 1
    }
    
    public func decrementCurrentTab() {
        self.currentTab -= 1
    }

}
