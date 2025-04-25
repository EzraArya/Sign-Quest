//
//  SQHomeCoordinatorView.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 25/04/25.
//

import SwiftUI

public struct SQHomeCoordinatorView: View {
    @StateObject var coordinator: SQHomeCoordinator = SQHomeCoordinator()
    
    public init() {}
    
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
