//
//  SQLevel.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

enum SQLevelStatus: String, Codable {
    case locked
    case available
    case completed
}

struct SQLevel: Codable, Identifiable, Hashable {
    let id: String
    let sectionId: String
    let number: Int
    let questions: [SQQuestion]
    let minScore: Int
    var status: SQLevelStatus
    
    var displayName: String {
        return "\(number)"
    }
    
    var progress: Double?
    
    var bestScore: Int?
    
    init(
        id: String = UUID().uuidString,
        sectionId: String,
        number: Int,
        questions: [SQQuestion] = [],
        minScore: Int,
        status: SQLevelStatus = .locked
    ) {
        self.id = id
        self.sectionId = sectionId
        self.number = number
        self.questions = questions
        self.minScore = minScore
        self.status = status
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Equality based on ID
    static func == (lhs: SQLevel, rhs: SQLevel) -> Bool {
        return lhs.id == rhs.id
    }
}
