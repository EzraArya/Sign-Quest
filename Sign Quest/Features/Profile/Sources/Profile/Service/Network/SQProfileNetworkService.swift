//
//  SQProfileNetworkService.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 06/05/25.
//

import SignQuestModels

protocol SQProfileNetworkServiceProtocol {
    func fetchProfile(userId: String) async throws -> SQUser
    func updateProfile(userId: String, profile: SQUser) async throws -> SQUser    
}

struct SQProfileNetworkService: SQProfileNetworkServiceProtocol {
    func fetchProfile(userId: String) async throws -> SQUser {
        return addMockUser()
    }
    
    func updateProfile(userId: String, profile: SQUser) async throws -> SQUser {
        return addMockUser()
    }
}

extension SQProfileNetworkService {
    func addMockUser() -> SQUser {
        return SQUser(
            firstName: "John",
            lastName: "Doe",
            email: "johndoe@gmail.com",
            age: 18,
            password: "pass",
            currentLevel: "5",
            totalScore: 20000
        )
    }
}
