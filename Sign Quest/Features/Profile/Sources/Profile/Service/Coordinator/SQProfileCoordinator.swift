//
//  SQProfileCoordinator.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import Combine
import SignQuestInterfaces

public enum SQProfileScreenType: Hashable, Identifiable {
    case profile
    case editProfile
    case editPassword
    
    public var id: Self { return self }
}

public class SQProfileCoordinator: NavigationCoordinatorProtocol {
    public typealias ScreenType = SQProfileScreenType
    @Published public var path: NavigationPath = NavigationPath()
    private weak var appCoordinator: (any AppCoordinatorProtocol)?
    
    public init(appCoordinator: any AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
    }
    
    public func push(_ screen: ScreenType) {
        path.append(screen)
    }
    
    public func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    public func popToRoot() {
        path = NavigationPath()
    }
    
    @MainActor
    public func navigateToWelcome() {
        appCoordinator?.startOnboarding()
    }
        
    @MainActor
    @ViewBuilder
    public func build(_ screen: ScreenType) -> some View {
        switch screen {
        case .profile:
            SQProfileView()
        case .editProfile:
            SQEditProfileView()
        case .editPassword:
            SQChangePasswordView()
        }
    }
}

