//
//  SQSection.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

public enum SQSectionStatus: String, Codable, Sendable {
    case locked
    case inProgress
    case completed
}

public struct SQSection: Codable, Identifiable, Hashable, Sendable {
    public let id: String
    public let number: Int
    public let title: String
    public let description: String
    public let levels: [SQLevel]
    public var status: SQSectionStatus
    
    public var displayName: String {
        return "Section \(number)"
    }
    
    public var completionPercentage: Double {
        guard !levels.isEmpty else { return 0.0 }
        let completedCount = levels.filter { level in
            return level.status == .completed
        }.count
        return Double(completedCount) / Double(levels.count) * 100.0
    }
    
    public init(
        id: String = UUID().uuidString,
        number: Int,
        title: String,
        description: String,
        levels: [SQLevel] = [],
        status: SQSectionStatus = .locked
    ) {
        self.id = id
        self.number = number
        self.title = title
        self.description = description
        self.levels = levels
        self.status = status
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: SQSection, rhs: SQSection) -> Bool {
        return lhs.id == rhs.id
    }
}
