//
//  SQPlayViewModel.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 02/05/25.
//

import Foundation
import SignQuestModels
import Combine

class SQPlayViewModel: ObservableObject, @unchecked Sendable {
    @Published var gameSession: SQGameSession?
    @Published var finalScore: Int = 0
    @Published var isLevelCompleted: Bool = false
    
    // This will be used to share data between different views
    static let shared = SQPlayViewModel()
    
    private init() {}
    
    func updateWithGameResults(session: SQGameSession, isCompleted: Bool) {
        self.gameSession = session
        self.finalScore = session.score
        self.isLevelCompleted = isCompleted
        
        // Print debug info
        print("SQPlayViewModel: Final score updated to \(finalScore), isCompleted: \(isCompleted)")
    }
    
    // Add a method to update the score during gameplay
    func updateScore(_ newScore: Int) {
        self.finalScore = newScore
        print("SQPlayViewModel: Score updated to \(newScore)")
    }
    
    func reset() {
        gameSession = nil
        finalScore = 0
        isLevelCompleted = false
    }
}
