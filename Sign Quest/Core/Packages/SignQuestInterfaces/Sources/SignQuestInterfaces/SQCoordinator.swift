//
//  SQCoordinator.swift
//  SignQuestInterfaces
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI

public protocol SQCoordinator: AnyObject {
    var navigationController: UINavigationController { get }
    @MainActor func start()
}

public protocol ViewCoordinator: AnyObject {
    associatedtype RootView: View
    @MainActor func makeRootView() -> RootView
}

public protocol OnboardingCoordinator: ViewCoordinator {
    func showWelcomeView()
    func showIntroductionView()
    @MainActor func finishOnboarding()
    @MainActor func showLoginView()
}

public protocol AuthenticationCoordinator: ViewCoordinator {
    func showLoginView()
    func showRegisterView()
    func showGreetingView()
    @MainActor func finishAuthentication()
}

public protocol TabCoordinator: ViewCoordinator {
    var tabIcon: String { get }
}

public protocol DashboardCoordinator: ViewCoordinator {
    var tabCoordinators: [any TabCoordinator] { get }
    @MainActor func showDashboardTabView() -> AnyView
}

public protocol HomeCoordinator: TabCoordinator {
    func showHomeView()
}

public protocol LeaderboardCoordinator: TabCoordinator {
    func showLeaderboardView()
}

public protocol ProfileCoordinator: TabCoordinator {
    func showProfileView()
    func showEditProfileView()
    func showEditPasswordView()
    @MainActor func logOut()
    @MainActor func deleteAccount()
}

public protocol SQAppCoordinator: SQCoordinator {
    var onboardingCoordinator: any OnboardingCoordinator { get }
    var authenticationCoordinator: any AuthenticationCoordinator { get }
    var homeCoordinator: any HomeCoordinator { get }
    var leaderboardCoordinator: any LeaderboardCoordinator { get }
    var profileCoordinator: any ProfileCoordinator { get }
    var dashboardCoordinator: any DashboardCoordinator { get }
    
    @MainActor func startOnboarding()
    @MainActor func startAuthentication(showRegister: Bool)
    @MainActor func startMainFlow()
}
