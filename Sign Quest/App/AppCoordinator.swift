//
//  AppCoordinator.swift
//  Sign Quest
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import Combine
import SignQuestInterfaces
import Onboarding
import Authentication
import Dashboard
import Home
import Leaderboard
import Profile
import Play
import SignQuestCore
import FirebaseAuth

public enum AppState {
    case onboarding
    case mainFlow
    case login
    case register
    case play
}

@MainActor
public class AppCoordinator: AppCoordinatorProtocol {
    @Published public var appState: AppState
    
    private var userManager: UserManager
    private var cancellables = Set<AnyCancellable>()

    public init(userManager: UserManager) {
        self.userManager = userManager
        if !UserDefaultsManager.shared.isOnboardingCompleted {
            self.appState = .onboarding
        } else {
            self.appState = userManager.authUser != nil ? .mainFlow : .login
        }
        setupAuthenticationListener()
    }
    
    private func setupAuthenticationListener() {
        userManager.$authUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self = self else { return }
                
                // Only react to auth changes if onboarding is complete.
                guard UserDefaultsManager.shared.isOnboardingCompleted else { return }

                if self.appState == .play {
                    // Do not change state if the user is in the middle of a game
                    return
                }

                if user != nil {
                    // A user is now logged in, switch to the main app flow.
                    self.appState = .mainFlow
                } else {
                    // The user logged out, switch to the login screen.
                    self.appState = .login
                }
            }
            .store(in: &cancellables)
    }
        
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
