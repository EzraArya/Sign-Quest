//
//  SQGamesViewModel.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 02/05/25.
//

import Foundation
import Combine
import SignQuestModels
import SignQuestCore
import UIKit
import SignQuestUI

@MainActor
class SQGamesViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var currentLevel: SQLevel?
    @Published var currentQuestionIndex: Int = 0
    @Published var currentQuestion: SQQuestion?
    @Published var gameSession: SQGameSession?
    @Published var selectedAnswerIndex: Int?
    @Published var isAnswerCorrect: Bool?
    @Published var progressPercentage: Double = 0
    @Published var score: Int = 0
    @Published var isProcessingGesture: Bool = false
    @Published var gestureLabel: String?
    @Published var cameraImage: UIImage? = nil
    @Published var isVerified: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // User information
    private var levelId: String
    private let networkService: SQPlayNetworkService = SQPlayNetworkService()
    private var coordinator: SQPlayCoordinator?
    private var userManager: UserManager?
    private var questions: [SQQuestion] = []
    
    // MARK: - Initialization
    init(levelId: String) {
        self.levelId = levelId
        // Don't call createGameSession() or loadData() here - wait for dependencies
    }
    
    func loadData() {
        Task {
            await loadContent()
        }
    }
    
    func link(userManager: UserManager, coordinator: SQPlayCoordinator) {
        self.userManager = userManager
        self.coordinator = coordinator
        
        // Now that dependencies are linked, create session and load data
        createGameSession()
        loadData()
    }

    
    // MARK: - Game Session Management
    private func createGameSession() {
        guard let userId = userManager?.firestoreUser?.id else {
            return
        }

        gameSession = SQGameSession(
            userId: userId,
            levelId: levelId
        )
    }

    // MARK: - Question Navigation
    func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            currentQuestion = questions[currentQuestionIndex]
            selectedAnswerIndex = nil
            isAnswerCorrect = nil
            updateProgress()
        } else {
            finishGame()
        }
    }
    
    // MARK: - Answer Handling
    func verifyAnswer(detectedGesture: String? = nil, expectedLabel: String? = nil) {
        guard let question = currentQuestion, let questionId = question.id else { return }
        let isCorrect: Bool
        
        switch question.type {
        case .performGesture:
            guard let detected = detectedGesture, let expected = expectedLabel else {
                return
            }
            isCorrect = detected.lowercased() == expected.lowercased()
            print("Gesture detection: \(detected) vs expected: \(expected) - \(isCorrect ? "correct" : "incorrect")")
            
        case .selectAlphabet, .selectGesture:
            guard let selectedIndex = selectedAnswerIndex else {
                return
            }
            isCorrect = (selectedIndex == question.correctAnswerIndex)
        }
        
        isAnswerCorrect = isCorrect
        
        updateSessionScore(questionId: questionId, isCorrect: isCorrect)
    }

    private func updateSessionScore(questionId: String, isCorrect: Bool) {
        guard var session = gameSession else { return }
        
        session.answeredQuestions[questionId] = isCorrect
        
        if isCorrect {
            session.score += 25
        } else {
        }
        
        gameSession = session
        score = session.score
        
        SQPlayViewModel.shared.updateScore(session.score)
    }
    
    // MARK: - Game Progress
    private func updateProgress() {
        progressPercentage = Double(currentQuestionIndex + 1) / Double(questions.count) * 100.0
    }

    private func finishGame() {
        guard let session = gameSession, let level = currentLevel else { return }
        
        let isCompleted = session.score >= level.minScore
        saveGameResults(session: session, level: level)
        
        SQPlayViewModel.shared.updateWithGameResults(
            session: session,
            isCompleted: isCompleted
        )
    }
    
    private func saveGameResults(session: SQGameSession, level: SQLevel) {
        // This would save the results to a repository
        print("Game finished with score: \(session.score)/\(questions.count * 25)")
    }
    
    // MARK: - Helper Methods
    func getQuestionType() -> SQQuestionType? {
        return currentQuestion?.type
    }
    
    func isLastQuestion() -> Bool {
        return currentQuestionIndex >= questions.count - 1
    }
}

extension SQGamesViewModel {
    func loadContent() async {
        do {
            isLoading = true
            errorMessage = nil
            
            let fetchedLevel = try await networkService.fetchLevel(levelId: levelId)
            let fetchedQuestions = try await networkService.fetchQuestions(levelId: levelId)
            
            self.currentLevel = fetchedLevel
            self.questions = fetchedQuestions
            
            if let firstQuestion = questions.first {
                self.currentQuestion = firstQuestion
                self.currentQuestionIndex = 0
                updateProgress()
            }
            
            isLoading = false

        } catch {
            errorMessage = "Failed to load content. Please try again."
            print("Error loading content: \(error)")
        }
    }
}

extension SQGamesViewModel {
    private func resetQuestionState() {
        self.cameraImage = nil
        self.gestureLabel = nil
        self.isVerified = false
        self.selectedAnswerIndex = nil
        self.isAnswerCorrect = nil
    }
    
    func handleAnswerButtonTap() {
        if !canProceed() {
            return
        }
        
        if isVerified {
            if isLastQuestion() {
                coordinator?.push(.finish)
            } else {
                moveToNextQuestion()
                resetQuestionState()
            }
        } else {
            verifyCurrentAnswer()
            isVerified = true
        }
    }
    
    private func verifyCurrentAnswer() {
        if getQuestionType() == .performGesture, let detectedLabel = gestureLabel {
            let expectedLabel = self.currentQuestion?.content.prompt ?? ""
            verifyAnswer(detectedGesture: detectedLabel, expectedLabel: expectedLabel)
        } else {
            verifyAnswer()
        }
    }
    
    private func canProceed() -> Bool {
        if getQuestionType() == .performGesture {
            return gestureLabel != nil
        } else {
            return selectedAnswerIndex != nil
        }
    }
    
    func determineButtonStyle() -> SQAnswerButtonStyle {
        if isVerified, let isCorrect = isAnswerCorrect {
            return isCorrect ? .correct : .incorrect
        }
        
        if selectedAnswerIndex != nil {
            return .default
        }
        
        return .disabled
    }
}
