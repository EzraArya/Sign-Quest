//
//  SQHomeContainerView.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI

struct SQHomeContainerView: View {
    let coordinator: SQHomeCoordinator
    @ObservedObject var navigationState: SQHomeCoordinator.NavigationState
    
    var body: some View {
        NavigationView {
            switch navigationState.currentScreen {
            case .dashboard:
                SQHomeView(coordinator: coordinator)
            }
        }
    }
}
