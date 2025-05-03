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
    @Published var gestureLabel: String?
    
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
    // Single method for verifying any type of answer
    func verifyAnswer(detectedGesture: String? = nil, expectedLabel: String? = nil) {
        guard let question = currentQuestion else { return }
        
        // Determine if the answer is correct based on question type
        let isCorrect: Bool
        
        switch question.type {
        case .performGesture:
            // For gesture questions, verify the detected gesture
            guard let detected = detectedGesture, let expected = expectedLabel else {
                print("Missing detected or expected label for gesture verification")
                return
            }
            isCorrect = detected.lowercased() == expected.lowercased()
            print("Gesture detection: \(detected) vs expected: \(expected) - \(isCorrect ? "correct" : "incorrect")")
            
        case .selectAlphabet, .selectGesture:
            // For choice questions, verify selected index matches correct index
            guard let selectedIndex = selectedAnswerIndex else {
                print("No answer selected for verification")
                return
            }
            isCorrect = (selectedIndex == question.correctAnswerIndex)
            print("Selected answer \(selectedIndex) for question \(question.id), correct: \(isCorrect)")
        }
        
        // Update the answer state
        isAnswerCorrect = isCorrect
        
        // Update session score
        updateSessionScore(questionId: question.id, isCorrect: isCorrect)
    }

    // Helper to update the session score
    private func updateSessionScore(questionId: String, isCorrect: Bool) {
        guard var session = gameSession else { return }
        
        // Record the answer
        session.answeredQuestions[questionId] = isCorrect
        
        // Update score if correct
        if isCorrect {
            session.score += 25
            print("Correct answer! +25 points")
        } else {
            print("Incorrect answer, no points added")
        }
        
        // Update session and score
        gameSession = session
        score = session.score
        
        // Update shared score
        SQPlayViewModel.shared.updateScore(session.score)
        print("Updated score to \(session.score)")
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
        return [
            addAlphabetQuestion(prompt: "hand.raised", correctIndex: 0),
            addGestureQuestion(prompt: "A", correctIndex: 1),
            addPerformQuestion(prompt: "A", alphabet: "A"),
            addGestureQuestion(prompt: "B", correctIndex: 0),
            addPerformQuestion(prompt: "C", alphabet: "C"),
            addGestureQuestion(prompt: "C", correctIndex: 1),
            addPerformQuestion(prompt: "Y", alphabet: "Y"),
        ]
    }
}

extension SQGamesViewModel {
    func addAlphabetQuestion(prompt: String, correctIndex: Int) -> SQQuestion{
        return SQQuestion(
            id: UUID().uuidString,
            type: .selectAlphabet,
            content: SQQuestionContent(
                prompt: prompt,
                isPromptImage: true,
                answers: [
                    SQAnswer(value: "A", isImage: false),
                    SQAnswer(value: "B", isImage: false),
                    SQAnswer(value: "C", isImage: false),
                    SQAnswer(value: "D", isImage: false)
                ]
            ),
            correctAnswerIndex: correctIndex
        )
    }
    
    func addGestureQuestion(prompt: String, correctIndex: Int) -> SQQuestion{
        return SQQuestion(
            id: UUID().uuidString,
            type: .selectGesture,
            content: SQQuestionContent(
                prompt: prompt,
                isPromptImage: false,
                answers: [
                    SQAnswer(value: "hand.raised", isImage: true),
                    SQAnswer(value: "hand.point.left", isImage: true),
                    SQAnswer(value: "hand.draw", isImage: true),
                    SQAnswer(value: "hand.wave", isImage: true)
                ]
            ),
            correctAnswerIndex: correctIndex
        )
    }
    
    func addPerformQuestion(prompt: String, alphabet: String) -> SQQuestion{
        return SQQuestion(
            id: UUID().uuidString,
            type: .performGesture,
            content: SQQuestionContent(
                prompt: prompt,
                isPromptImage: false,
                answers: [
                    SQAnswer(value: alphabet, isImage: false)
                ]
            ),
            correctAnswerIndex: 0
        )
    }
}
