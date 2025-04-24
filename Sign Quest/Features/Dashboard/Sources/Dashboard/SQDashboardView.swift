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
    private let coordinator: SQDashboardCoordinator
    @State private var selectedTab = 0
    
    public init(coordinator: SQDashboardCoordinator) {
        self.coordinator = coordinator
        
        // Configure tab bar appearance
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
                ForEach(Array(coordinator.tabCoordinators.enumerated()), id: \.offset) { index, tabCoordinator in
                    AnyView(tabCoordinator.makeRootView())
                        .tabItem {
                            SQImage(image: tabCoordinator.tabIcon)
                        }
                        .tag(index)
                }
            }
            .tint(SQColor.accent.color)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .applyBackground()
    }
}
