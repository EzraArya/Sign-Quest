//
//  SQDashboardCoordinator.swift
//  Dashboard
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestUI
import SignQuestInterfaces

public class SQDashboardCoordinator: DashboardCoordinator {
    private weak var appCoordinator: SQAppCoordinator?
    
    public var tabCoordinators: [any TabCoordinator] {
        guard let appCoordinator = appCoordinator else { return [] }
        return [
            appCoordinator.homeCoordinator,
            appCoordinator.leaderboardCoordinator,
            appCoordinator.profileCoordinator
        ]
    }
    
    public init(appCoordinator: SQAppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor
    public func makeRootView() -> some View {
        showDashboardTabView()
    }
    
    @MainActor
    public func showDashboardTabView() -> AnyView {
        guard let appCoordinator = appCoordinator else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            SQDashboardView(coordinator: self)
        )
    }
}
