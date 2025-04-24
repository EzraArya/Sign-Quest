//
//  SQProfileContainerView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI

struct SQProfileContainerView: View {
    let coordinator: SQProfileCoordinator
    @ObservedObject var navigationState: SQProfileCoordinator.NavigationState
    
    var body: some View {
        NavigationView {
            switch navigationState.currentScreen {
            case .profile:
                SQProfileView(coordinator: coordinator)
                    .toolbar(.visible, for: .tabBar)
            case .editProfile:
                SQEditProfileView(coordinator: coordinator)
                    .toolbar(.hidden, for: .tabBar)
            case .editPassword:
                SQChangePasswordView(coordinator: coordinator)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}
