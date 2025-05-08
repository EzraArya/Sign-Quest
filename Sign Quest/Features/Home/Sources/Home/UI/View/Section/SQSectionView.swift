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
        Binding<String?>(
            get: {
                viewModel.activePopup?.sectionId == section.id ? viewModel.activePopup?.levelId : nil
            },
            set: { newValue in
                if let levelId = newValue {
                    viewModel.activePopup = (section.id, levelId)
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

            HStack {
                SQText(text: "Progress:", font: .medium, color: .secondary, size: 16)
                ProgressView(value: section.completionPercentage / 100)
                    .progressViewStyle(LinearProgressViewStyle())
                SQText(
                    text: "\(Int(section.completionPercentage))%",
                    font: .medium,
                    color: .primary,
                    size: 16
                )
            }
            .padding(.top, 8)

            VStack(spacing: 30) {
                ForEach(section.levels) { level in
                    VStack(spacing: 4) {
                        SQLevelButton(
                            level: level.displayName,
                            style: viewModel.getLevelButtonStyle(for: level),
                            activePopup: sectionLevelBinding,
                            action: viewModel.canNavigate(to: level) ? {
                                viewModel.navigateToGame(for: level)
                            } : nil
                        )

                        if let bestScore = level.bestScore {
                            SQText(
                                text: "Best Score: \(bestScore)/\(level.questions.count * 10)",
                                font: .medium,
                                color: .secondary,
                                size: 14
                            )
                        }
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
