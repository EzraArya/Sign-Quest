//
//  SQIntroductionView.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI
import SignQuestCore

public struct SQIntroductionView: View {
    @EnvironmentObject private var coordinator: SQOnboardingCoordinator

    @StateObject private var viewModel = SQIntroductionViewModel()
    @Environment(\.dismiss) private var dismiss

    private let dotSize: CGFloat = 8
    private let activeDotSize: CGFloat = 10
    private let dotSpacing: CGFloat = 8
    
    @State private var navigateToRegistration = false
    
    public init() {}
    
    public var body: some View {
        VStack {
            TabView(selection: $viewModel.currentTab) {
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
                        .fill(index == viewModel.currentTab ? SQColor.primary.color : SQColor.muted.color)
                        .frame(width: index == viewModel.currentTab ? activeDotSize : dotSize,
                               height: index == viewModel.currentTab ? activeDotSize : dotSize)
                        .animation(.easeInOut, value: viewModel.currentTab)
                }
            }
            .padding(.bottom, 24)
            
            SQButton(text: viewModel.currentTab < viewModel.pages.count - 1 ? "Continue" : "Create Profile", font: .bold, style: .default, size: 16) {
                if viewModel.currentTab < viewModel.pages.count - 1 {
                    viewModel.incrementCurrentTab()
                } else {
                    viewModel.navigateToRegistration()
                }
            }
        }
        .padding(.horizontal, 24)
        .applyBackground()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if viewModel.currentTab == 0 {
                        viewModel.navigateBack()
                    } else {
                        viewModel.decrementCurrentTab()
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
                        viewModel.navigateToRegistration()
                    }
            }
        }
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}
