//
//  SQAuthenticationCoordinator.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public enum SQAuthenticationScreenType: Hashable, Identifiable {
    case login
    case register
    case greet
    
    public var id: Self { return self }
}

public class SQAuthenticationCoordinator: NavigationCoordinatorProtocol {
    
    public typealias ScreenType = SQAuthenticationScreenType
    @Published public var path: NavigationPath = NavigationPath()
    
    private weak var appCoordinator: (any AppCoordinatorProtocol)?
    
    public init(appCoordinator: any AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
    }
    
    public func push(_ screen: SQAuthenticationScreenType) {
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
    public func showOnboarding() {
        appCoordinator?.startOnboarding()
    }
    
    @MainActor
    public func showMainFlow() {
        appCoordinator?.startMainFlow()
    }

    @MainActor
    @ViewBuilder
    public func build(_ screen: ScreenType) -> some View {
        switch screen {
        case .login:
            SQLoginView()
        case .register:
            SQRegisterView()
        case .greet:
            SQGreetView()
        }
    }
}
