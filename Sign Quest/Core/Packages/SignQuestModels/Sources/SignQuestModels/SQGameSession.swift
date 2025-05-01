//
//  SQGameSession.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

public struct SQGameSession: Codable, Identifiable {
    public let id: String
    public let userId: String
    public let levelId: String
    public var currentQuestionIndex: Int
    public var answeredQuestions: [String: Bool]
    public var score: Int
    public var startTime: Date
    
    public init(
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
