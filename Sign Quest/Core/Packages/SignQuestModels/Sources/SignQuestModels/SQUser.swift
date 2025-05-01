//
//  SQUser.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

public struct SQUser: Hashable, Identifiable, Sendable {
    public let id: String
    public var firstName: String
    public var lastName: String
    public var email: String
    public var age: Int
    public var password: String
    public var createdAt: Date
    
    public var currentLevel: String?
    
    public init(id: String = UUID().uuidString, firstName: String, lastName: String, email: String, age: Int, password: String, createdAt: Date = Date(), currentLevel: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.password = password
        self.createdAt = createdAt
        self.currentLevel = currentLevel
    }
    
    public var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
