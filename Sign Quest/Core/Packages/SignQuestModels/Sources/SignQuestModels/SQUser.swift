//
//  SQUser.swift
//  SignQuestModels
//
//  Created by Ezra Arya Wijaya on 27/04/25.
//

import Foundation

struct SQUser: Hashable, Identifiable {
    let id: String
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var password: String
    var createdAt: Date
    
    var currentLevel: String?
    
    init(id: String = UUID().uuidString, firstName: String, lastName: String, email: String, age: Int, password: String, createdAt: Date, currentLevel: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.password = password
        self.createdAt = Date()
        self.currentLevel = currentLevel
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
