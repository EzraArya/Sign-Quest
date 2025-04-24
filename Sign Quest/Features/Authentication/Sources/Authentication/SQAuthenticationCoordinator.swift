//
//  SQAuthenticationCoordinator.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public class SQAuthenticationCoordinator: AuthenticationCoordinator {
    public class NavigationState: ObservableObject {
        public enum Screen {
            case login
            case register
            case greet
        }
        
        @Published var currentScreen: Screen = .login
    }
    
    @Published public var navigationState = NavigationState()
    private weak var appCoordinator: SQAppCoordinator?
    
    public init(appCoordinator: SQAppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor
    public func makeRootView() -> some View {
        SQAuthenticationContainerView(coordinator: self, navigationState: navigationState)
    }
    
    @MainActor
    public func showWelcomeView() {
        appCoordinator?.startOnboarding()
    }
    
    @MainActor public func showLoginView() {
        navigationState.currentScreen = .login
    }
    
    public func showRegisterView() {
        appCoordinator?.hideNavigationBar()
        navigationState.currentScreen = .register
    }
    
    public func showGreetingView() {
        navigationState.currentScreen = .greet
    }
    
    public func finishAuthentication() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        appCoordinator?.startMainFlow()
    }
}
