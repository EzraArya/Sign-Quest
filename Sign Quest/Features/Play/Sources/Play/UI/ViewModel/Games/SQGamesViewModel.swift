//
//  SQGamesViewModel.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 02/05/25.
//

import Foundation
import Combine
import SignQuestModels
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
    
    // User information
    private var userId: String
    private var levelId: String
    private let networkService: SQPlayNetworkService = SQPlayNetworkService()
    private var coordinator: SQPlayCoordinator?
    
    // MARK: - Initialization
    init(userId: String, levelId: String) {
        self.userId = userId
        self.levelId = levelId
        
        createGameSession()
        loadData()
    }
    
    func loadData() {
        Task { @MainActor in
            await loadLevelData()
        }
    }
    
    func setCoordinator(_ coordinator: SQPlayCoordinator) {
        self.coordinator = coordinator
    }

    
    // MARK: - Game Session Management
    private func createGameSession() {
        gameSession = SQGameSession(
            userId: userId,
            levelId: levelId
        )
    }
    
    @MainActor
    private func loadLevelData() async {
        currentLevel = await fetchLevel(levelId: levelId)

        if let firstQuestion = currentLevel?.questions.first {
            currentQuestion = firstQuestion
            updateProgress()
        }
    }


    // MARK: - Question Navigation
    func moveToNextQuestion() {
        guard let level = currentLevel, !level.questions.isEmpty else { return }
        
        if currentQuestionIndex < level.questions.count - 1 {
            currentQuestionIndex += 1
            currentQuestion = level.questions[currentQuestionIndex]
            selectedAnswerIndex = nil
            isAnswerCorrect = nil
            updateProgress()
        } else {
            finishGame()
        }
    }
    
    // MARK: - Answer Handling
    func verifyAnswer(detectedGesture: String? = nil, expectedLabel: String? = nil) {
        guard let question = currentQuestion else { return }
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
        
        updateSessionScore(questionId: question.id, isCorrect: isCorrect)
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
        guard let level = currentLevel, !level.questions.isEmpty else { return }
        progressPercentage = Double(currentQuestionIndex + 1) / Double(level.questions.count) * 100.0
    }

    private func finishGame() {
        guard let session = gameSession, let level = currentLevel else { return }
        
        var updatedLevel = level
        let isCompleted = session.score >= level.minScore
        if isCompleted {
            updatedLevel.status = .completed
            updatedLevel.bestScore = max(session.score, level.bestScore ?? 0)
        }
        
        saveGameResults(session: session, level: updatedLevel)
        
        SQPlayViewModel.shared.updateWithGameResults(
            session: session,
            isCompleted: isCompleted
        )
    }
    
    private func saveGameResults(session: SQGameSession, level: SQLevel) {
        // This would save the results to a repository
        print("Game finished with score: \(session.score)/\(level.questions.count * 25)")
    }
    
    // MARK: - Helper Methods
    func getQuestionType() -> SQQuestionType? {
        return currentQuestion?.type
    }
    
    func isLastQuestion() -> Bool {
        guard let level = currentLevel else { return true }
        return currentQuestionIndex >= level.questions.count - 1
    }
}

extension SQGamesViewModel {
    @MainActor
    func fetchLevel(levelId: String) async -> SQLevel {
        return await networkService.fetchLevel(levelId: levelId)
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
