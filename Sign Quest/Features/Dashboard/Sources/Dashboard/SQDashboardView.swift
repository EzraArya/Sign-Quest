//
//  SQDashboardView.swift
//  Dashboard
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI
import SignQuestInterfaces

public struct SQDashboardView: View {
    @StateObject var coordinator: SQDashboardCoordinator = SQDashboardCoordinator()
    
    private let homeCoordinatorView: AnyView
    private let leaderboardCoordinatorView: AnyView
    private let profileCoordinatorView: AnyView
    
    public init(
        homeCoordinatorView: some View,
        leaderboardCoordinatorView: some View,
        profileCoordinatorView: some View
    ) {
        self.homeCoordinatorView = AnyView(homeCoordinatorView)
        self.leaderboardCoordinatorView = AnyView(leaderboardCoordinatorView)
        self.profileCoordinatorView = AnyView(profileCoordinatorView)
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(SQColor.background.color)
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(SQColor.muted.color)
        appearance.shadowColor = UIColor(SQColor.line.color)
        appearance.shadowImage = UIImage.createSolidImage(color: UIColor(SQColor.line.color), size: CGSize(width: 1, height: 1))
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
           
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    public var body: some View {
        VStack {
            TabView(selection: $coordinator.activeTab) {
                homeCoordinatorView
                    .tabItem {
                        SQImage(image: SQTabType.home.iconName)
                    }
                    .tag(SQTabType.home)
                    
                leaderboardCoordinatorView
                    .tabItem {
                        SQImage(image: SQTabType.leaderboard.iconName)
                    }
                    .tag(SQTabType.leaderboard)
                
                profileCoordinatorView
                    .tabItem {
                        SQImage(image: SQTabType.profile.iconName)
                    }
                    .tag(SQTabType.profile)
            }
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .tint(SQColor.accent.color)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .applyBackground()
        .environmentObject(coordinator)
    }
}
