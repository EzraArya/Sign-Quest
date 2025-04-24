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

@MainActor
public class AppCoordinator: SQAppCoordinator {
    public static func create() -> AppCoordinator {
        AppCoordinator(navigationController: UINavigationController())
    }
    
    public lazy var onboardingCoordinator: any SignQuestInterfaces.OnboardingCoordinator = SQOnboardingCoordinator(appCoordinator: self)
    
    public lazy var authenticationCoordinator: any SignQuestInterfaces.AuthenticationCoordinator = SQAuthenticationCoordinator(appCoordinator: self)
    
    public var navigationController: UINavigationController
    
    public lazy var homeCoordinator: any HomeCoordinator = SQHomeCoordinator(appCoordinator: self)
    public lazy var leaderboardCoordinator: any LeaderboardCoordinator = SQLeaderboardCoordinator(appCoordinator: self)
    public lazy var profileCoordinator: any ProfileCoordinator = SQProfileCoordinator(appCoordinator: self)
    public lazy var dashboardCoordinator: any DashboardCoordinator = SQDashboardCoordinator(appCoordinator: self)
    
    private init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
    }
    
    public func start() {
        if UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
            if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                startMainFlow()
            } else {
                startAuthentication()
            }
        } else {
            startOnboarding()
        }
    }
    
    public func startOnboarding() {
        let rootView = onboardingCoordinator.makeRootView()
        setRootView(AnyView(rootView))
        onboardingCoordinator.showWelcomeView()
    }
    
    public func startAuthentication(showRegister: Bool = false) {
        let rootView = authenticationCoordinator.makeRootView()
        setRootView(AnyView(rootView))
        
        if showRegister {
            authenticationCoordinator.showRegisterView()
        } else {
            authenticationCoordinator.showLoginView()
        }
    }
    
    public func hideNavigationBar() {
        navigationController.isNavigationBarHidden = true
    }

    public func showNavigationBar() {
        navigationController.isNavigationBarHidden = false
    }
    
    public func startMainFlow() {
        let rootView = dashboardCoordinator.makeRootView()
        setRootView(AnyView(rootView))
    }
    
    private func setRootView<V: View>(_ view: V) {
        let hostingController = UIHostingController(rootView: view)
        navigationController.setViewControllers([hostingController], animated: true)
    }
}
