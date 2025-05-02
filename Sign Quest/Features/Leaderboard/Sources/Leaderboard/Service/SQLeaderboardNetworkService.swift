//
//  SQLeaderboardNetworkService.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 02/05/25.
//

import SignQuestModels

struct SQLeaderboardNetworkService {
    func fetchLeaderboardData() async -> [SQUser] {
        let mockUsers = [
            SQUser(firstName: "John", lastName: "Doe", email: "email@gmail.com", age: 18, password: "", totalScore: 17000),
            SQUser(firstName: "Alice", lastName: "Se", email: "email@gmail.com", age: 18, password: "", totalScore: 1700),
            SQUser(firstName: "Jo", lastName: "Si", email: "email@gmail.com", age: 18, password: "", totalScore: 170),
            SQUser(firstName: "Si", lastName: "Tu", email: "email@gmail.com", age: 18, password: "", totalScore: 12000),
            SQUser(firstName: "Jo", lastName: "Ko", email: "email@gmail.com", age: 18, password: "", totalScore: 20000),
        ]
        return mockUsers
    }
}
