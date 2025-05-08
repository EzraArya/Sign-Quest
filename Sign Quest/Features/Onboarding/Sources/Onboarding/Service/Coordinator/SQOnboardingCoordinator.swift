//
//  SQOnboardingCoordinator.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public enum SQOnboardingScreenType: Hashable, Identifiable {
    case welcome
    case introduction
    
    public var id: Self { return self }
}

public class SQOnboardingCoordinator: NavigationCoordinatorProtocol {
    public typealias ScreenType = SQOnboardingScreenType
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
    public func showAuthentication(isLogin: Bool = true) {
        appCoordinator?.startAuthentication(isLogin: isLogin)
    }
        
    @MainActor
    @ViewBuilder
    public func build(_ screen: ScreenType) -> some View {
        switch screen {
        case .welcome:
            SQWelcomeView()
        case .introduction:
            SQIntroductionView()
        }
    }
}
