//
//  SQOnboardingCoordinatorView.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 25/04/25.
//

import SwiftUI
import SignQuestInterfaces

public struct SQOnboardingCoordinatorView: View {
    let appCoordinator: any AppCoordinatorProtocol
    @StateObject var coordinator: SQOnboardingCoordinator
    public init(appCoordinator: any AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
        _coordinator = StateObject(wrappedValue: SQOnboardingCoordinator(appCoordinator: appCoordinator))
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(.welcome)
                .navigationDestination(for: SQOnboardingScreenType.self) { screen in
                    coordinator.build(screen)
                }
        }
        .environmentObject(coordinator)
    }
}

