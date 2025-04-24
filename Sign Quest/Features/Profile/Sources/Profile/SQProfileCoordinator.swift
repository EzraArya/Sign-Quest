//
//  SQProfileCoordinator.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public class SQProfileCoordinator: ProfileCoordinator {
    private weak var appCoordinator: SQAppCoordinator?
    private var navigationState = NavigationState()
    
    public var tabIcon: String = "person"
    
    public init(appCoordinator: SQAppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor
    public func makeRootView() -> some View {
        return SQProfileContainerView(coordinator: self, navigationState: navigationState)
    }
    
    public func showProfileView() {
        navigationState.currentScreen = .profile
    }
    
    public func showEditProfileView() {
        navigationState.currentScreen = .editProfile
    }
    
    public func showEditPasswordView() {
        navigationState.currentScreen = .editPassword
    }
    
    @MainActor
    public func logOut() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        appCoordinator?.startOnboarding()
    }
    
    @MainActor
    public func deleteAccount() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        appCoordinator?.startOnboarding()
    }
        
    class NavigationState: ObservableObject {
        enum Screen {
            case profile
            case editProfile
            case editPassword
        }
        
        @Published var currentScreen: Screen = .profile
    }
    
    public func navigateBack() {
        if navigationState.currentScreen == .editPassword {
            navigationState.currentScreen = .editProfile
        } else {
            navigationState.currentScreen = .profile
        }
    }
}

