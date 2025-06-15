//
//  LevelManager.swift
//  SignQuestCore
//
//  Created by Ezra Arya Wijaya on 13/06/25.
//

import SignQuestModels

public final class LevelManager: @unchecked Sendable {
    static let shared = LevelManager()
    private let networkService: LevelServiceProtocol
    
    private init(networkService: LevelServiceProtocol = LevelService()) {
        self.networkService = networkService
    }
    
    private func fetchLevel(by id: String) async throws -> SQLevel {
        return try await networkService.fetchLevel(levelId: id)
    }
    
    private func userLevelData(for userId: String, by levelId: String) async throws -> SQUserLevelData {
        return try await networkService.fetchUserLevelData(userId: userId, levelId: levelId)
    }
    
    private func fetchQuestions(for levelId: String) async throws -> [SQQuestion] {
        return try await networkService.fetchQuestions(for: levelId)
    }
    
    private func updateUserLevelData(_ data: SQUserLevelData, for userId: String, levelId: String) async throws {
        try await networkService.updateUserLevelData(for: userId, levelId: levelId, userLevelData: data)
    }
}
