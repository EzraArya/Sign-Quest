//
//  SQWelcomeView.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI
import Combine
import SignQuestCore

public struct SQWelcomeView: View {
    @EnvironmentObject private var coordinator: SQOnboardingCoordinator
    @StateObject var viewModel = SQWelcomeViewModel()
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            VStack(spacing: 24) {
                SQText(text: viewModel.title, font: .bold, color: .secondary, size: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                SQButton(text: viewModel.buttonTitle, font: .bold, style: .default, size: 16) {
                    Task { @MainActor in
                        coordinator.showAuthentication(isLogin: true)
                    }
                }
            }
            
            SQSeperator(color: .line)
                    
            VStack(spacing: 24) {
                SQText(text: viewModel.subtitle, font: .bold, color: .secondary, size: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                SQButton(text: viewModel.buttonSubtitle, font: .bold, style: .secondary, size: 16) {
                    UserDefaultsManager.shared.isOnboardingCompleted = true
                    coordinator.push(.introduction)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .applyBackground()
    }
}
