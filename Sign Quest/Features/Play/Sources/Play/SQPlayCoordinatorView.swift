//
//  SQPlayCoordinatorView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//


import SwiftUI
import SignQuestInterfaces

public struct SQPlayCoordinatorView: View {
    let appCoordinator: any AppCoordinatorProtocol
    @StateObject var coordinator: SQPlayCoordinator

    public init(appCoordinator: any AppCoordinatorProtocol, ) {
        self.appCoordinator = appCoordinator
        _coordinator = StateObject(wrappedValue: SQPlayCoordinator(appCoordinator: appCoordinator))
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.loading)
                .navigationDestination(for: SQPlayScreenType.self) { screen in
                    coordinator.build(screen)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet)
                }
        }
        .environmentObject(coordinator)
    }
}
