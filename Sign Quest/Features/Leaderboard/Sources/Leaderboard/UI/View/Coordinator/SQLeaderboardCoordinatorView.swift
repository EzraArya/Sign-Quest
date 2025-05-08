//
//  SQLeaderboardCoordinatorView.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 25/04/25.
//

import SwiftUI

public struct SQLeaderboardCoordinatorView: View {
    @StateObject var coordinator: SQLeaderboardCoordinator = SQLeaderboardCoordinator()
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.leaderboard)
                .navigationDestination(for: SQLeaderboardScreenType.self) { screen in
                    coordinator.build(screen)
                }
        }
        .environmentObject(coordinator)
    }
}
