//
//  AppCoordinatorView.swift
//  Sign Quest
//
//  Created by Ezra Arya Wijaya on 25/04/25.
//

import SwiftUI

public struct AppCoordinatorView: View {
    @StateObject var appCoordinator: AppCoordinator = AppCoordinator()
    
    public init() {}
    
    public var body: some View {
        ZStack {
            appCoordinator.makeRootView()
        }
        .environmentObject(appCoordinator)
    }
}
