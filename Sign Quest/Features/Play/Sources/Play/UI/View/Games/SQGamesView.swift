//
//  SQGamesView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQGamesView: View {
    @EnvironmentObject var coordinator: SQPlayCoordinator
    @StateObject private var viewModel: SQGamesViewModel
    @State private var cameraImage: UIImage? = nil
    @State private var hasProcessedGesture: Bool = false
    
    public init(userId: String = "demo-user", levelId: String = "demo-level") {
        _viewModel = StateObject(wrappedValue: SQGamesViewModel(userId: userId, levelId: levelId))
    }
    
    public var body: some View {
        VStack {
            // Top navigation and progress bar
            HStack {
                Button {
                    coordinator.presentSheet(.setting)
                } label: {
                    Image(systemName: "gearshape")
                        .bold()
                        .foregroundColor(SQColor.secondary.color)
                }
                
                Spacer()
                
                SQProgressBar(progress: $viewModel.progressPercentage)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 8)
            
            // Question content
            if let question = viewModel.currentQuestion {
                // Display appropriate question type based on question.type
                switch question.type {
                case .selectAlphabet:
                    SQGamesTypeOnePage(
                        promptImage: question.content.prompt,
                        answerOptions: question.content.answers.map { $0.value },
                        onAnswerSelected: { index in
                            viewModel.selectAnswer(at: index)
                        }
                    )
                case .selectGesture:
                    SQGamesTypeTwoPage(
                        promptText: question.content.prompt,
                        answerOptions: question.content.answers.map { $0.value },
                        onAnswerSelected: { index in
                            viewModel.selectAnswer(at: index)
                        }
                    )
                case .performGesture:
                    SQGamesTypeThreePage(
                        promptText: question.content.prompt,
                        selectedImage: $cameraImage
                    )
                    .onChange(of: cameraImage) { oldImage, newImage in
                        if let _ = newImage, !hasProcessedGesture {
                            viewModel.selectAnswer(at: 0)
                            hasProcessedGesture = true
                        }
                    }
                }
            } else {
                // Show loading or empty state
                Text("Loading...")
            }
            
            Spacer()
            
            // Next/Finish button
            SQButton(
                text: viewModel.isLastQuestion() ? "Finish" : "Next",
                font: .bold,
                style: .muted,
                size: 16
            ) {
                if viewModel.isLastQuestion() {
                    coordinator.push(.finish)
                } else {
                    viewModel.moveToNextQuestion()
                    // Reset state for next question
                    cameraImage = nil
                    hasProcessedGesture = false
                }
            }
            .padding(.horizontal, 24)
            .disabled(viewModel.selectedAnswerIndex == nil && viewModel.getQuestionType() != .performGesture)
        }
        .applyBackground()
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(viewModel)
    }
}
