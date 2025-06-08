//
//  SQHomeView.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI
import SignQuestModels
import SignQuestCore

public struct SQHomeView: View {
    @EnvironmentObject var coordinator: SQHomeCoordinator
    @EnvironmentObject var userManager: UserManager
    @StateObject var viewModel: SQHomeViewModel = SQHomeViewModel()
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    SQText(text: "Welcome,", font: .bold, color: .secondary, size: 24)
                    SQText(text: userManager.firestoreUser?.fullName ?? "User", font: .bold, color: .primary, size: 24)
                }
                .padding(.top, 8)
                
                if !viewModel.sections.isEmpty {
                    ForEach(viewModel.sections) { section in
                        SectionView(section: section, viewModel: viewModel)
                            .padding(.bottom, 24)
                    }
                } else {
                    SQText(
                        text: "No sections available yet",
                        font: .medium,
                        color: .secondary,
                        size: 18
                    )
                }
                
                Spacer(minLength: 60)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .applyBackground()
        .onAppear {
            viewModel.setCoordinator(coordinator)
            Task {
                if viewModel.sections.isEmpty, let userID = userManager.authUser?.uid {
                    await viewModel.loadContent(forUserID: userID)
                }
            }
        }
    }
}

