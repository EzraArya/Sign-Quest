//
//  SQDashboardCoordinator.swift
//  Dashboard
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestUI
import SignQuestInterfaces

public enum SQTabType: String, CaseIterable, Hashable {
    case home
    case leaderboard
    case profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .leaderboard:
            return "trophy"
        case .profile:
            return "person"
        }
    }
}

@MainActor
public class SQDashboardCoordinator: TabBarCoordinatorProtocol {
    public typealias TabType = SQTabType
    public var activeTab: SQTabType = .home
    
    public init() {}
    
    public func switchTab(to tab: SQTabType) {
        activeTab = tab
    }
}
