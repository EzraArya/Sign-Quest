//
//  SQScoreView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI
import Firebase

public struct SQScoreView: View {
    @EnvironmentObject var coordinator: SQPlayCoordinator
    @EnvironmentObject private var viewModel: SQGamesViewModel

    public init() {}
    
    public var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 8) {
                SQText(
                    text: viewModel.isLevelCompleted ? "🥳" : "😊",
                    font: .bold,
                    color: .text,
                    size: 76
                )
                SQText(text: "Your Score", font: .bold, color: .text, size: 24)
                SQText(
                    text: "\(viewModel.finalScore)",
                    font: .bold,
                    color: viewModel.isLevelCompleted ? .complementary : .secondary,
                    size: 32
                )
                
                if viewModel.isLevelCompleted {
                    SQText(
                        text: "Level Completed!",
                        font: .bold,
                        color: .complementary,
                        size: 18
                    )
                    .padding(.top, 8)
                } else {
                    SQText(
                        text: "Keep practicing!",
                        font: .bold,
                        color: .secondary,
                        size: 18
                    )
                    .padding(.top, 8)
                }
            }
            
            Spacer()
            
            SQButton(text: "Continue", font: .bold, style: .default, size: 16) {
                coordinator.navigateToHome()
            }
        }
        .padding(.horizontal, 24)
        .applyBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}
