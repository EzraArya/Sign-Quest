//
//  AppCoordinator.swift
//  Sign Quest
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import UIKit
import SignQuestInterfaces
import Onboarding
import Authentication
import Dashboard
import Home
import Leaderboard
import Profile
import Play
import SignQuestCore

public enum AppState {
    case onboarding
    case mainFlow
    case login
    case register
    case play
}

@MainActor
public class AppCoordinator: AppCoordinatorProtocol {
    // Initialize the appState based on the user's progress:
    // - If onboarding is completed, check if the user is logged in:
    //   - If logged in, set the state to .mainFlow.
    //   - Otherwise, set the state to .login.
    // - If onboarding is not completed, set the state to .onboarding.
    @Published public var appState: AppState = {
        let defaults = UserDefaultsManager.shared
        if defaults.isOnboardingCompleted {
            if defaults.isLoggedIn {
                return .mainFlow
            } else {
                return .login
            }
        } else {
            return .onboarding
        }
    }()
    
    public init() {}
        
    public func startOnboarding() {
        appState = .onboarding
    }
    
    public func startMainFlow() {
        appState = .mainFlow
    }
    
    public func startAuthentication(isLogin: Bool) {
        if isLogin {
            appState = .login
        } else {
            appState = .register
        }
    }
    
    public func startGame() {
        appState = .play
    }
    
    @ViewBuilder
    public func makeRootView() -> some View {
        switch appState {
        case .onboarding:
            SQOnboardingCoordinatorView(appCoordinator: self)
        case .login:
            SQAuthenticationCoordinatorView(appCoordinator: self, initialScreen: .login)
        case .register:
            SQAuthenticationCoordinatorView(appCoordinator: self, initialScreen: .register)
        case .mainFlow:
            SQDashboardView(
                homeCoordinatorView: SQHomeCoordinatorView(
                    appCoordinator: self
                ),
                leaderboardCoordinatorView: SQLeaderboardView(),
                profileCoordinatorView: SQProfileCoordinatorView(
                    appCoordinator: self
                )
            )
        case .play:
            SQPlayCoordinatorView(appCoordinator: self)
        }
    }
}
