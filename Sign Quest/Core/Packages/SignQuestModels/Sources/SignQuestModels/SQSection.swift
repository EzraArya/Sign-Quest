//
//  SQSection.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

enum SQSectionStatus: String, Codable {
    case locked
    case inProgress
    case completed
}

struct SQSection: Codable, Identifiable, Hashable {
    let id: String
    let number: Int
    let title: String
    let description: String
    let levels: [SQLevel]
    var status: SQSectionStatus
    
    var displayName: String {
        return "Section \(number)"
    }
    
    var completionPercentage: Double {
        guard !levels.isEmpty else { return 0.0 }
        let completedCount = levels.filter { level in
            return level.status == .completed
        }.count
        return Double(completedCount) / Double(levels.count) * 100.0
    }
    
    init(
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SQSection, rhs: SQSection) -> Bool {
        return lhs.id == rhs.id
    }
}
