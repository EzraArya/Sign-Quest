//
//  SQLevel.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation
import FirebaseFirestore

public enum SQLevelStatus: String, Codable, Sendable {
    case locked
    case available
    case completed
}

public struct SQLevel: Codable, Identifiable, Hashable, @unchecked Sendable {
    @DocumentID public var id: String?
    public let sectionId: String
    public let number: Int
    public let minScore: Int
    
    public var displayName: String {
        return "\(number)"
    }
    
}
