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
    
    public func showLoginView() {
        navigationState.currentScreen = .login
    }
    
    public func showRegisterView() {
        navigationState.currentScreen = .register
    }
    
    public func showGreetingView() {
        navigationState.currentScreen = .greet
    }
    
    public func finishAuthentication() {
        appCoordinator?.startMainFlow()
    }
}
