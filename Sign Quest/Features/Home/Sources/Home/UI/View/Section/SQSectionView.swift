//
//  SQSectionView.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import SignQuestModels
import SignQuestUI

struct SectionView: View {
    let section: SQSection
    @ObservedObject var viewModel: SQHomeViewModel
    private var sectionLevelBinding: Binding<String?> {
        Binding(
            get: {
                viewModel.activePopup?.sectionId == section.id ? viewModel.activePopup?.levelId : nil
            },
            set: { newValue in
                if let levelId = newValue {
                    viewModel.activePopup = ActivePopup(sectionId: section.id ?? "1", levelId: levelId)
                } else {
                    viewModel.activePopup = nil
                }
            }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SQBanner(
                section: section.displayName,
                title: section.title
            )

            VStack(spacing: 30) {
                ForEach(viewModel.levels(for: section)) { level in
                    VStack(spacing: 4) {
                        SQLevelButton(
                            level: level.displayName,
                            style: viewModel.getLevelButtonStyle(for: level),
                            title: level.title,
                            subtitle: level.description,
                            activePopup: sectionLevelBinding,
                            action: viewModel.canNavigate(to: level) ? {
                                viewModel.navigateToGame(for: level)
                            } : nil
                        )
                    }
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 12)

            Divider()
                .padding(12)

            Spacer()
        }
    }
}
