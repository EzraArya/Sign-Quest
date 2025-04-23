//
//  SQDashboardView.swift
//  Dashboard
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI
import Home
import Profile

public struct SQDashboardView: View {
    @State private var selectedTab = 0
    @State private var homePath = NavigationPath()
    @State private var profilePath = NavigationPath()
    
    public init() {
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
            TabView(selection: $selectedTab) {
                SQHomeView()
                    .withNavigation(path: $homePath)
                    .tabItem {
                        SQImage(image: "house")
                    }
                    .tag(0)
                Text("Leaderboard")
                    .applyBackground()
                    .tabItem {
                        SQImage(image: "trophy")
                    }
                    .tag(1)
                SQProfileView(profilePath: $profilePath)
                    .withNavigation(path: $profilePath)
                    .tabItem {
                        SQImage(image: "person")
                    }
                    .tag(2)
            }
            .tint(SQColor.accent.color)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .applyBackground()
    }
}
