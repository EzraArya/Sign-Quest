//
//  SQGameSession.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

struct SQGameSession: Codable, Identifiable {
    let id: String
    let userId: String
    let levelId: String
    var currentQuestionIndex: Int
    var answeredQuestions: [String: Bool]
    var score: Int
    var startTime: Date
    
    init(
        id: String = UUID().uuidString,
        userId: String,
        levelId: String,
        currentQuestionIndex: Int = 0,
        answeredQuestions: [String: Bool] = [:],
        score: Int = 0,
        startTime: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.levelId = levelId
        self.currentQuestionIndex = currentQuestionIndex
        self.answeredQuestions = answeredQuestions
        self.score = score
        self.startTime = startTime
    }
}
