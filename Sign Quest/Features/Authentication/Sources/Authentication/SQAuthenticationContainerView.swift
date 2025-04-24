//
//  SQAuthenticationContainerView.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI

struct SQAuthenticationContainerView: View {
    let coordinator: SQAuthenticationCoordinator
    @ObservedObject var navigationState: SQAuthenticationCoordinator.NavigationState
    
    var body: some View {
        NavigationView {
            switch navigationState.currentScreen {
            case .login:
                SQLoginView(coordinator: coordinator)
            case .register:
                SQRegisterView(coordinator: coordinator)
            case .greet:
                SQGreetView(coordinator: coordinator)
                    
            }
        }
        .navigationViewStyle(.stack)
    }
}
