//
//  SQLeaderboardContainerView.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI

struct SQLeaderboardContainerView: View {
    let coordinator: SQLeaderboardCoordinator
    @ObservedObject var navigationState: SQLeaderboardCoordinator.NavigationState
    
    var body: some View {
        NavigationView {
            switch navigationState.currentScreen {
            case .dashboard:
                SQLeaderboardView(coordinator: coordinator)
            }
        }
    }
}

