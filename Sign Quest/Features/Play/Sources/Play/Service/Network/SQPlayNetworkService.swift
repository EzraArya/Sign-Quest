//
//  SQPlayNetworkService.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 04/05/25.
//

import SignQuestModels
import Firebase
import Foundation

protocol SQPlayNetworkServiceProtocol {
    func fetchLevel(levelId: String) async throws -> SQLevel
    func fetchQuestions(levelId: String) async throws -> [SQQuestion]
    func updateUserLevelData(userId: String, levelId: String, userLevelData: SQUserLevelData) async throws
}

struct SQPlayNetworkService: SQPlayNetworkServiceProtocol, Sendable {
    func fetchLevel(levelId: String) async throws -> SQLevel {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("levels")
            .document(levelId)
            .getDocument()
        return try snapshot.data(as: SQLevel.self)
    }
    
    func fetchQuestions(levelId: String) async throws -> [SQQuestion] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("questions")
            .whereField("levelId", isEqualTo: levelId)
            .getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: SQQuestion.self) }
    }
    
    func updateUserLevelData(userId: String, levelId: String, userLevelData: SQUserLevelData) async throws {
        let db = Firestore.firestore()
        let docRef = db.collection("users")
            .document(userId)
            .collection("levelData").document(levelId)
        
        try docRef.setData(from: userLevelData, merge: true)
    }
}
