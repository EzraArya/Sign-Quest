//
//  SQUser.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation
import FirebaseFirestore

public struct SQUser: Codable, Hashable, Identifiable, @unchecked Sendable {
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
    
    public init(firstName: String, lastName: String, email: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        
        self.id = nil
        self.createdAt = nil
        self.image = nil
        self.totalScore = 0
        self.currentLevel = nil
    }

    public var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
