//
//  LevelService.swift
//  SignQuestCore
//
//  Created by Ezra Arya Wijaya on 13/06/25.
//

import SignQuestModels
import FirebaseFirestore

protocol LevelServiceProtocol {
    func fetchLevel(levelId: String) async throws -> SQLevel?
    func fetchUserLevelData(userId: String, levelId: String) async throws-> SQUserLevelData?
    func updateUserLevelData(for userId: String, levelId: String, userLevelData: SQUserLevelData) async throws
    func fetchQuestions(for levelId: String) async throws -> [SQQuestion]?
}

struct LevelService: LevelServiceProtocol {
    func fetchLevel(levelId: String) async throws -> SQLevel? {
        let db = Firestore.firestore()
        return try await db.collection("levels").document(levelId).getDocument(as: SQLevel.self)
    }
    
    func fetchUserLevelData(userId: String, levelId: String) async throws-> SQUserLevelData? {
        let db = Firestore.firestore()
        return try await db.collection("users").document(userId).collection("levelData").document(levelId).getDocument(as: SQUserLevelData.self)
    }
    
    func updateUserLevelData(for userId: String, levelId: String, userLevelData: SQUserLevelData) async throws {
        let db = Firestore.firestore()
        try db.collection("users").document(userId).collection("levelData").document(levelId).setData(from: userLevelData)
    }
    
    func fetchQuestions(for levelId: String) async throws -> [SQQuestion]? {
        let db = Firestore.firestore()
        return try await db.collection("questions").whereField("levelId", isEqualTo: levelId).getDocuments().documents.compactMap { document in
            try? document.data(as: SQQuestion.self)
        }
    }
}
