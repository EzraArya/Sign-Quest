//
//  SQHomeCoordinatorView.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 25/04/25.
//

import SwiftUI
import SignQuestInterfaces

public struct SQHomeCoordinatorView: View {
    @StateObject var coordinator: SQHomeCoordinator
    let appCoordinator: any AppCoordinatorProtocol
    public init(appCoordinator: any AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
        _coordinator = StateObject(wrappedValue: SQHomeCoordinator(appCoordinator: appCoordinator))
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.home)
                .navigationDestination(for: SQHomeScreenType.self) { screen in
                    coordinator.build(screen)
                }
        }
        .environmentObject(coordinator)
    }
}
