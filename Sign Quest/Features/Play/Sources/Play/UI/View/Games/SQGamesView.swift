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
    @State private var gestureLabel: String? = nil
    @State private var isVerified: Bool = false
    
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
            VStack {
                if let question = viewModel.currentQuestion {
                    switch question.type {
                    case .selectAlphabet:
                        SQGamesTypeOnePage(
                            promptImage: question.content.prompt,
                            answerOptions: question.content.answers.map { $0.value },
                            onAnswerSelected: { index in
                                viewModel.selectedAnswerIndex = index
                                viewModel.isAnswerCorrect = nil
                                isVerified = false
                            }
                        )
                    case .selectGesture:
                        SQGamesTypeTwoPage(
                            promptText: question.content.prompt,
                            answerOptions: question.content.answers.map { $0.value },
                            onAnswerSelected: { index in
                                viewModel.selectedAnswerIndex = index
                                viewModel.isAnswerCorrect = nil
                                isVerified = false
                            }
                        )
                    case .performGesture:
                        SQGamesTypeThreePage(
                            promptText: question.content.prompt,
                            selectedImage: $cameraImage,
                            gestureLabel: $gestureLabel
                        )
                    }
                } else {
                    Text("Loading...")
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            // Answer button with three-step flow
            SQAnswerButton(
                style: determineButtonStyle(),
                isCorrect: viewModel.isAnswerCorrect ?? false
            ) {
                handleAnswerButtonTap()
            }
        }
        .applyBackground()
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(viewModel)
        .onChange(of: viewModel.currentQuestion) {
            // Reset state when question changes
            isVerified = false
            gestureLabel = nil
            viewModel.selectedAnswerIndex = nil
            viewModel.isAnswerCorrect = nil
        }
        .onChange(of: gestureLabel) { _, newLabel in
            // When gesture label is detected, enable the button
            if newLabel != nil && viewModel.getQuestionType() == .performGesture {
                viewModel.selectedAnswerIndex = 0  // Dummy index to enable button
            }
        }
        .onChange(of: cameraImage) { _, newImage in
            if newImage == nil {
                // Reset when image is cleared
                viewModel.selectedAnswerIndex = nil
            }
        }
    }
          
    private func resetQuestionState() {
        cameraImage = nil
        gestureLabel = nil
        isVerified = false
        viewModel.selectedAnswerIndex = nil
        viewModel.isAnswerCorrect = nil
    }
    
    private func handleAnswerButtonTap() {
            if !canProceed() {
                return
            }
            
            if isVerified {
                if viewModel.isLastQuestion() {
                    coordinator.push(.finish)
                } else {
                    viewModel.moveToNextQuestion()
                    resetQuestionState()
                }
            } else {
                verifyCurrentAnswer()
                isVerified = true
            }
        }
        
        private func verifyCurrentAnswer() {
            if viewModel.getQuestionType() == .performGesture, let detectedLabel = gestureLabel {
                let expectedLabel = viewModel.currentQuestion?.content.prompt ?? ""
                viewModel.verifyAnswer(detectedGesture: detectedLabel, expectedLabel: expectedLabel)
            } else {
                viewModel.verifyAnswer()
            }
        }
        
        private func canProceed() -> Bool {
            if viewModel.getQuestionType() == .performGesture {
                return gestureLabel != nil
            } else {
                return viewModel.selectedAnswerIndex != nil
            }
        }
        
        private func determineButtonStyle() -> SQAnswerButtonStyle {
            if isVerified, let isCorrect = viewModel.isAnswerCorrect {
                return isCorrect ? .correct : .incorrect
            }
            
            if viewModel.selectedAnswerIndex != nil {
                return .default
            }
            
            return .disabled
        }
    }
