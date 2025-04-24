//
//  SQLeaderboardCoordinator.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public class SQLeaderboardCoordinator: LeaderboardCoordinator {
    private weak var appCoordinator: SQAppCoordinator?
    private var navigationState = NavigationState()
    
    public var tabIcon: String = "trophy"
    
    public init(appCoordinator: SQAppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor
    public func makeRootView() -> some View {
        return SQLeaderboardContainerView(coordinator: self, navigationState: navigationState)
    }
    
    public func showLeaderboardView() {
        navigationState.currentScreen = .dashboard
    }
        
    class NavigationState: ObservableObject {
        enum Screen {
            case dashboard
        }
        
        @Published var currentScreen: Screen = .dashboard
    }
}
