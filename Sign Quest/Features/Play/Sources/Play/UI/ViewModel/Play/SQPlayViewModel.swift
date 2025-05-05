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
    
    static let shared = SQPlayViewModel()
    
    private init() {}
    
    func updateWithGameResults(session: SQGameSession, isCompleted: Bool) {
        self.gameSession = session
        self.finalScore = session.score
        self.isLevelCompleted = isCompleted
    }
    
    func updateScore(_ newScore: Int) {
        self.finalScore = newScore
    }
    
    func reset() {
        gameSession = nil
        finalScore = 0
        isLevelCompleted = false
    }
}
