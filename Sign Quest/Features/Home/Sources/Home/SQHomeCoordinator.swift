//
//  SQHomeCoordinator.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public enum SQHomeScreenType: Hashable, Identifiable {
    case home
    
    public var id: Self { return self }
}

public class SQHomeCoordinator: NavigationCoordinatorProtocol {
    public typealias ScreenType = SQHomeScreenType
    
    @Published public var path: NavigationPath = NavigationPath()
    private weak var appCoordinator: (any AppCoordinatorProtocol)?
    
    public init(appCoordinator: (any AppCoordinatorProtocol)? = nil) {
        self.appCoordinator = appCoordinator
    }
    
    public func push(_ screen: SQHomeScreenType) {
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
    public func navigateToGame() {
        appCoordinator?.startGame()
    }
    
    @MainActor
    @ViewBuilder
    public func build(_ screen: ScreenType) -> some View {
        switch screen {
        case .home:
            SQHomeView()
        }
    }
}
