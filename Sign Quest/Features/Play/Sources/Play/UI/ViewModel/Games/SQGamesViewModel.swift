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
    
    // User information
    private var userId: String
    private var levelId: String
    
    // MARK: - Initialization
    init(userId: String, levelId: String) {
        self.userId = userId
        self.levelId = levelId
        
        // Create a new game session
        createGameSession()
        
        // Load level data - In a real app, this would fetch from a repository
        loadLevelData()
    }
    
    // MARK: - Game Session Management
    private func createGameSession() {
        gameSession = SQGameSession(
            userId: userId,
            levelId: levelId
        )
    }
    
    private func loadLevelData() {
        // In a real app, this would fetch from a repository
        // For now, we'll create a sample level
        let sampleQuestions = createSampleQuestions()
        
        currentLevel = SQLevel(
            id: levelId,
            sectionId: "sample-section-id",
            number: 1,
            questions: sampleQuestions,
            minScore: 70,
            status: .available
        )
        
        // Set the first question
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
            // Game finished
            finishGame()
        }
    }
    
    // MARK: - Answer Handling
    func selectAnswer(at index: Int) {
        // Only process the answer if one hasn't been selected yet or if it's a gesture recognition
        guard selectedAnswerIndex == nil || getQuestionType() == .performGesture else {
            print("Answer already selected - ignoring additional selection")
            return
        }
        
        selectedAnswerIndex = index
        
        guard let question = currentQuestion else { return }
        
        var isCorrect = false
        
        if question.type == .performGesture {
            // For performGesture, we assume the image recognition system
            // already determined if it's correct (typically index 0)
            isCorrect = (index == 0)
            print("Performance gesture answer: \(isCorrect ? "correct" : "incorrect")")
        } else {
            isCorrect = (index == question.correctAnswerIndex)
            print("Selected answer \(index) for question \(question.id), correct answer is \(question.correctAnswerIndex)")
        }
        
        isAnswerCorrect = isCorrect
        
        // Update session data
        if let session = gameSession {
            var updatedSession = session
            updatedSession.answeredQuestions[question.id] = isCorrect
            if isCorrect {
                updatedSession.score += 25
                print("Correct answer! +25 points")
            } else {
                print("Incorrect answer, no points added")
            }
            
            gameSession = updatedSession
            score = updatedSession.score
            
            SQPlayViewModel.shared.updateScore(updatedSession.score)
            print("Updated SQPlayViewModel.shared score to \(updatedSession.score)")
        }
    }
        
    // MARK: - Game Progress
    private func updateProgress() {
        guard let level = currentLevel, !level.questions.isEmpty else { return }
        progressPercentage = Double(currentQuestionIndex + 1) / Double(level.questions.count) * 100.0
    }

    private func finishGame() {
        guard let session = gameSession, let level = currentLevel else { return }
        
        // Update level status based on score
        var updatedLevel = level
        let isCompleted = session.score >= level.minScore
        if isCompleted {
            updatedLevel.status = .completed
            updatedLevel.bestScore = max(session.score, level.bestScore ?? 0)
        }
        
        // Save session results and update shared view model
        saveGameResults(session: session, level: updatedLevel)
        
        // Update shared view model with final results
        SQPlayViewModel.shared.updateWithGameResults(
            session: session,
            isCompleted: isCompleted
        )
        
        // Debug print the final results
        print("Final game results - Score: \(session.score), Min required: \(level.minScore), Completed: \(isCompleted)")
        print("Answered questions: \(session.answeredQuestions)")
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
    
    // MARK: - Sample Data (for demonstration)
    private func createSampleQuestions() -> [SQQuestion] {
        // Create sample questions based on the three game types in your UI
        
        // Type 1: Select Alphabet
        let alphabetQuestion = SQQuestion(
            id: UUID().uuidString,
            type: .selectAlphabet,
            content: SQQuestionContent(
                prompt: "hand.raised.fill",
                isPromptImage: true,
                answers: [
                    SQAnswer(value: "A", isImage: false),
                    SQAnswer(value: "B", isImage: false),
                    SQAnswer(value: "C", isImage: false),
                    SQAnswer(value: "D", isImage: false)
                ]
            ),
            correctAnswerIndex: 0
        )
        
        // Type 2: Select Gesture
        let gestureQuestion = SQQuestion(
            id: UUID().uuidString,
            type: .selectGesture,
            content: SQQuestionContent(
                prompt: "A",
                isPromptImage: false,
                answers: [
                    SQAnswer(value: "hand.raised", isImage: true),
                    SQAnswer(value: "hand.point.left", isImage: true),
                    SQAnswer(value: "hand.draw", isImage: true),
                    SQAnswer(value: "hand.wave", isImage: true)
                ]
            ),
            correctAnswerIndex: 0
        )
        
        // Type 3: Perform Gesture
        let performQuestion = SQQuestion(
            id: UUID().uuidString,
            type: .performGesture,
            content: SQQuestionContent(
                prompt: "A",
                isPromptImage: false,
                answers: [
                    SQAnswer(value: "A", isImage: false)
                ]
            ),
            correctAnswerIndex: 0
        )
        
        return [alphabetQuestion, gestureQuestion, performQuestion, alphabetQuestion]
    }
}
