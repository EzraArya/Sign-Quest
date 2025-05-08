//
//  SQLeaderboardCoordinator.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public enum SQLeaderboardScreenType: Hashable, Identifiable {
    case leaderboard
    
    public var id: Self { return self }
}

public class SQLeaderboardCoordinator: NavigationCoordinatorProtocol {
    public typealias ScreenType = SQLeaderboardScreenType
    @Published public var path: NavigationPath = NavigationPath()
    
    public func push(_ screen: SQLeaderboardScreenType) {
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
    @ViewBuilder
    public func build(_ screen: ScreenType) -> some View {
        switch screen {
        case .leaderboard:
            SQLeaderboardView()
        }
    }
}
