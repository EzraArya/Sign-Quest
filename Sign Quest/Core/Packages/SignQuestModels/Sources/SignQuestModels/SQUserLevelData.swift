//
//  SQUserLevelData.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 06/06/25.
//
import FirebaseFirestore

public enum SQUserLevelDataStatus: String, Codable {
    case available = "available"
    case completed = "completed"
    case locked = "locked"
}

public struct SQUserLevelData: Codable, Identifiable {
    @DocumentID
    public var id: String?
    
    public let status: SQUserLevelDataStatus
    public let bestScore: Int
    
    @ServerTimestamp
    public var lastAttempted: Date?
}
