//
//  SQUser.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

public struct SQUser: Hashable, Identifiable {
    public let id: String
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var password: String
    var createdAt: Date
    
    var currentLevel: String?
    
    public init(id: String = UUID().uuidString, firstName: String, lastName: String, email: String, age: Int, password: String, createdAt: Date = Date(), currentLevel: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.password = password
        self.createdAt = createdAt
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
