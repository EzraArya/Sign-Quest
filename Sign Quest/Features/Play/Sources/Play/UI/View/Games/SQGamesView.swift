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
    
    public init(userId: String = "demo-user", levelId: String = "demo-level") {
        _viewModel = StateObject(wrappedValue: SQGamesViewModel(userId: userId, levelId: levelId))
    }
    
    public var body: some View {
        VStack {
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
                                viewModel.isVerified = false
                            }
                        )
                    case .selectGesture:
                        SQGamesTypeTwoPage(
                            promptText: question.content.prompt,
                            answerOptions: question.content.answers.map { $0.value },
                            onAnswerSelected: { index in
                                viewModel.selectedAnswerIndex = index
                                viewModel.isAnswerCorrect = nil
                                viewModel.isVerified = false
                            }
                        )
                    case .performGesture:
                        SQGamesTypeThreePage(
                            promptText: question.content.prompt,
                            selectedImage: $viewModel.cameraImage,
                            gestureLabel: $viewModel.gestureLabel
                        )
                    }
                } else {
                    ProgressView()
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            SQAnswerButton(
                style: viewModel.determineButtonStyle(),
                isCorrect: viewModel.isAnswerCorrect ?? false
            ) {
                viewModel.handleAnswerButtonTap()
            }
        }
        .applyBackground()
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(viewModel)
        .onChange(of: viewModel.currentQuestion) {
            viewModel.isVerified = false
            viewModel.gestureLabel = nil
            viewModel.selectedAnswerIndex = nil
            viewModel.isAnswerCorrect = nil
        }
        .onChange(of: viewModel.gestureLabel) { _, newLabel in
            if newLabel != nil && viewModel.getQuestionType() == .performGesture {
                viewModel.selectedAnswerIndex = 0  // Dummy index to enable button
            }
        }
        .onChange(of: viewModel.cameraImage) { _, newImage in
            if newImage == nil {
                viewModel.selectedAnswerIndex = nil
            }
        }
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}

