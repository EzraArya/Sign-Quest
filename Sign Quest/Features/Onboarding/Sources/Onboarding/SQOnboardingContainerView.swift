//
//  SQOnboardingContainer.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI

struct SQOnboardingContainerView: View {
    let coordinator: SQOnboardingCoordinator
    @ObservedObject var navigationState: SQOnboardingCoordinator.NavigationState
    
    var body: some View {
        switch navigationState.currentScreen {
        case .welcome:
            SQWelcomeView(coordinator: coordinator)
        case .introduction:
            SQIntroductionView(coordinator: coordinator)
        }
    }
}
