//
//  SQWelcomeView.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI
import Combine

public struct SQWelcomeView: View {
    let coordinator: SQOnboardingCoordinator
    
    @StateObject var viewModel = SQWelcomeViewModel()
    @State private var navigateToIntroduction: Bool = false
    @State private var navigateToSignIn: Bool = false
    
    public init(coordinator: SQOnboardingCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            VStack(spacing: 24) {
                SQText(text: viewModel.title, font: .bold, color: .secondary, size: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                SQButton(text: viewModel.buttonTitle, font: .bold, style: .default, size: 16) {
                    coordinator.showLoginView()
                }
            }
            
            SQSeperator(color: .line)
                    
            VStack(spacing: 24) {
                SQText(text: viewModel.subtitle, font: .bold, color: .secondary, size: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                SQButton(text: viewModel.buttonSubtitle, font: .bold, style: .secondary, size: 16) {
                    coordinator.showIntroductionView()
                }
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .applyBackground()
    }
}
