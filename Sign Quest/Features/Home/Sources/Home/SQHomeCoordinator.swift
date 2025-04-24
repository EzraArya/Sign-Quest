//
//  SQHomeCoordinator.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestInterfaces

public class SQHomeCoordinator: HomeCoordinator {
    private weak var appCoordinator: SQAppCoordinator?
    private var navigationState = NavigationState()
    
    public var tabIcon: String = "house"
    
    public init(appCoordinator: SQAppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor
    public func makeRootView() -> some View {
        return SQHomeContainerView(coordinator: self, navigationState: navigationState)
    }
    
    public func showHomeView() {
        navigationState.currentScreen = .dashboard
    }
        
    class NavigationState: ObservableObject {
        enum Screen {
            case dashboard
        }
        
        @Published var currentScreen: Screen = .dashboard
    }
}
