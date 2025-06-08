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
import SignQuestUI

public enum AppState {
    case onboarding
    case mainFlow
    case login
    case register
    case play
    case greet
}

@MainActor
public class AppCoordinator: AppCoordinatorProtocol {
    @Published public var appState: AppState
    
    private var userManager: UserManager
    private var cancellables = Set<AnyCancellable>()

    public init(userManager: UserManager) {
        self.userManager = userManager
        
        print("🔍 Determining initial app state...")
        
        if !UserDefaultsManager.shared.isOnboardingCompleted {
            print("➡️ Onboarding not completed, showing onboarding")
            self.appState = .onboarding
        } else if let currentUser = Auth.auth().currentUser {
            print("✅ Found authenticated user: \(currentUser.uid)")
            print("   Email: \(currentUser.email ?? "No email")")
            self.appState = .greet
        } else {
            print("❌ No authenticated user found, showing login")
            self.appState = .login
        }
        
        setupAuthenticationListener()
        
        if let currentUser = Auth.auth().currentUser {
            validateUserToken(currentUser)
        }
    }
    
    private func validateUserToken(_ user: User) {
        user.getIDToken { [weak self] token, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Token validation failed: \(error)")
                    print("   Redirecting to login")
                    self?.appState = .login
                } else if token == nil {
                    print("⚠️ No token found, redirecting to login")
                    self?.appState = .login
                } else {
                    print("✅ Token is valid, auto-login successful")
                }
            }
        }
    }
    
    private func setupAuthenticationListener() {
        userManager.$authUser
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self = self else { return }
                
                print("🔄 Auth state changed: \(user?.uid ?? "nil")")
                
                if self.appState == .onboarding || self.appState == .play {
                    print("   Ignoring auth change during \(self.appState)")
                    return
                }
                
                if user != nil {
                    if self.appState == .login || self.appState == .register {
                        print("   User logged in, transitioning to greet")
                        self.appState = .greet
                    }
                } else {
                    print("   User logged out, transitioning to login")
                    self.appState = .login
                }
            }
            .store(in: &cancellables)
    }

    public func startOnboarding() {
        appState = .onboarding
    }
    
    public func completeOnboarding() {
        UserDefaultsManager.shared.isOnboardingCompleted = true
        
        if Auth.auth().currentUser != nil {
            appState = .greet
        } else {
            appState = .login
        }
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
            
        case .greet:
            SQAuthenticationCoordinatorView(appCoordinator: self, initialScreen: .greet)

        }
    }
}
