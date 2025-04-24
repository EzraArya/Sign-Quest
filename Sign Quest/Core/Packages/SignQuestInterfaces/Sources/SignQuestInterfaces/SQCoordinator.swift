//
//  SQCoordinator.swift
//  SignQuestInterfaces
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI

@MainActor
public protocol SQCoordinator: AnyObject {
    var navigationController: UINavigationController { get }
    @MainActor func start()
}

@MainActor
public protocol ViewCoordinator: AnyObject {
    associatedtype RootView: View
    @MainActor func makeRootView() -> RootView
}

@MainActor
public protocol OnboardingCoordinator: ViewCoordinator {
    func showWelcomeView()
    func showIntroductionView()
    func finishOnboarding()
    func showLoginView()
}

@MainActor
public protocol AuthenticationCoordinator: ViewCoordinator {
    func showLoginView()
    func showRegisterView()
    func showGreetingView()
    func showWelcomeView()
    func finishAuthentication()
}

@MainActor
public protocol TabCoordinator: ViewCoordinator {
    var tabIcon: String { get }
}

@MainActor
public protocol DashboardCoordinator: ViewCoordinator {
    var tabCoordinators: [any TabCoordinator] { get }
    func showDashboardTabView() -> AnyView
}

@MainActor
public protocol HomeCoordinator: TabCoordinator {
    func showHomeView()
}

@MainActor
public protocol LeaderboardCoordinator: TabCoordinator {
    func showLeaderboardView()
}

@MainActor
public protocol ProfileCoordinator: TabCoordinator {
    func showProfileView()
    func showEditProfileView()
    func showEditPasswordView()
    func logOut()
    func deleteAccount()
}

@MainActor
public protocol SQAppCoordinator: SQCoordinator {
    var onboardingCoordinator: any OnboardingCoordinator { get }
    var authenticationCoordinator: any AuthenticationCoordinator { get }
    var homeCoordinator: any HomeCoordinator { get }
    var leaderboardCoordinator: any LeaderboardCoordinator { get }
    var profileCoordinator: any ProfileCoordinator { get }
    var dashboardCoordinator: any DashboardCoordinator { get }
    
    func startOnboarding()
    func startAuthentication(showRegister: Bool)
    func startMainFlow()
    func hideNavigationBar()
    func showNavigationBar()
}
