//
//  SQLevel.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

public enum SQLevelStatus: String, Codable, Sendable {
    case locked
    case available
    case completed
}

public struct SQLevel: Codable, Identifiable, Hashable, Sendable {
    public let id: String
    public let sectionId: String
    public let number: Int
    public let questions: [SQQuestion]
    public let minScore: Int
    public var status: SQLevelStatus
    
    public var displayName: String {
        return "\(number)"
    }
    
    public var progress: Double?
    
    public var bestScore: Int?
    
    public init(
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
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Equality based on ID
    public static func == (lhs: SQLevel, rhs: SQLevel) -> Bool {
        return lhs.id == rhs.id
    }
}
