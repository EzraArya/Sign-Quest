//
//  SQOnboardingCoordinator.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public class SQOnboardingCoordinator: OnboardingCoordinator {
    private weak var appCoordinator: SQAppCoordinator?
    private var navigationState = NavigationState()
    
    public init(appCoordinator: SQAppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor
    public func makeRootView() -> some View {
        return SQOnboardingContainerView(coordinator: self, navigationState: navigationState)
    }
    
    public func showWelcomeView() {
        navigationState.currentScreen = .welcome
    }
    
    public func showIntroductionView() {
        appCoordinator?.showNavigationBar()
        navigationState.currentScreen = .introduction
    }
    
    @MainActor
    public func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        appCoordinator?.startAuthentication(showRegister: true)
    }
        
    @MainActor
    public func showLoginView() {
        appCoordinator?.startAuthentication(showRegister: false)
    }
    
    class NavigationState: ObservableObject {
        enum Screen {
            case welcome
            case introduction
        }
        
        @Published var currentScreen: Screen = .welcome
    }
}
