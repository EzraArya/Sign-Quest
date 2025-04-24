//
//  SQIntroductionView.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQIntroductionView: View {
    let coordinator: SQOnboardingCoordinator
    
    @State private var currentTab = 0
    @StateObject private var viewModel = SQIntroductionViewModel()
    @Environment(\.dismiss) private var dismiss

    private let dotSize: CGFloat = 8
    private let activeDotSize: CGFloat = 10
    private let dotSpacing: CGFloat = 8
    
    @State private var navigateToRegistration = false
    
    public init(coordinator: SQOnboardingCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        VStack {
            TabView(selection: $currentTab) {
                ForEach(0..<viewModel.pages.count, id: \.self) { index in
                    let page = viewModel.pages[index]
                    SQIntroductionPageView(title: page.title, boldTitle: page.boldTitle, subtitle: page.subtitle)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
            HStack(spacing: dotSpacing) {
                ForEach(0..<viewModel.pages.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentTab ? SQColor.primary.color : SQColor.muted.color)
                        .frame(width: index == currentTab ? activeDotSize : dotSize,
                               height: index == currentTab ? activeDotSize : dotSize)
                        .animation(.easeInOut, value: currentTab)
                }
            }
            .padding(.bottom, 24)
            
            SQButton(text: currentTab < viewModel.pages.count - 1 ? "Continue" : "Create Profile", font: .bold, style: .default, size: 16) {
                if currentTab < viewModel.pages.count - 1 {
                    currentTab += 1
                } else {
                    coordinator.finishOnboarding()
                }
            }
        }
        .padding(.horizontal, 24)
        .applyBackground()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if currentTab == 0 {
                        coordinator.showWelcomeView()
                    } else {
                        currentTab -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(SQColor.secondary.color)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                SQText(text: "Skip", font: .bold, color: .secondary, size: 16)
                    .onTapGesture {
                        coordinator.finishOnboarding()
                    }
            }
        }
    }
}
