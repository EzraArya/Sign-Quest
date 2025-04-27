//
//  SQProgress.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

struct SQProgress: Codable, Identifiable {
    let id: String
    let userId: String
    let sectionId: String
    let levelId: String
    let score: Int
    let completedAt: Date
    
    init(
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
