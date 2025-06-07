//
//  SQAuthenticationCoordinatorView.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 25/04/25.
//

import SwiftUI
import SignQuestInterfaces

public struct SQAuthenticationCoordinatorView: View {
    let appCoordinator: any AppCoordinatorProtocol
    @StateObject var coordinator: SQAuthenticationCoordinator
    var initialScreen: SQAuthenticationScreenType = .login

    public init(appCoordinator: any AppCoordinatorProtocol, initialScreen: SQAuthenticationScreenType) {
        self.initialScreen = initialScreen
        self.appCoordinator = appCoordinator
        _coordinator = StateObject(wrappedValue: SQAuthenticationCoordinator(appCoordinator: appCoordinator))
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(initialScreen)
                .navigationDestination(for: SQAuthenticationScreenType.self) { screen in
                    coordinator.build(screen)
                }
        }
        .environmentObject(coordinator)
    }
}
