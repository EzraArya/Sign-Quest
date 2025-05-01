//
//  SQProgress.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

public struct SQProgress: Codable, Identifiable {
    public let id: String
    public let userId: String
    public let sectionId: String
    public let levelId: String
    public let score: Int
    public let completedAt: Date
    
    public init(
        id: String = UUID().uuidString,
        userId: String,
        sectionId: String,
        levelId: String,
        score: Int,
        completedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.sectionId = sectionId
        self.levelId = levelId
        self.score = score
        self.completedAt = completedAt
    }
}
