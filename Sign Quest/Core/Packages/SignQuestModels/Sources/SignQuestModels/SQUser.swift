//
//  SQUser.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation
import FirebaseFirestore

public struct SQUser: Codable, Hashable, Identifiable {
    @DocumentID
    public var id: String?
    
    public var firstName: String
    public var lastName: String
    public var email: String
    public var age: Int
    
    @ServerTimestamp
    public var createdAt: Date?
    
    public var image: String?
    public var currentLevel: String?
    public var totalScore: Int
    
    public var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
