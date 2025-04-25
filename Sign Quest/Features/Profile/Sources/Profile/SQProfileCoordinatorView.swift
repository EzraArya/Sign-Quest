//
//  SQProfileCoordinatorView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 25/04/25.
//

import SwiftUI
import SignQuestInterfaces

public struct SQProfileCoordinatorView: View {
    @StateObject var coordinator: SQProfileCoordinator
    let appCoordinator: any AppCoordinatorProtocol
    public init(appCoordinator: any AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
        _coordinator = StateObject(wrappedValue: SQProfileCoordinator(appCoordinator: appCoordinator))
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.profile)
                .navigationDestination(for: SQProfileScreenType.self) { screen in
                    coordinator.build(screen)
                }
        }
        .environmentObject(coordinator)
    }
}
