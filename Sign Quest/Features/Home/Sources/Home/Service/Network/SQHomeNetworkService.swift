//
//  SQHomeNetworkService.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//
import FirebaseFirestore
import SignQuestModels

protocol SQHomeNetworkServiceProtocol: Sendable {
    func fetchSections() async throws -> [SQSection]
    func fetchLevels() async throws -> [SQLevel]
    func fetchUserLevelData(for userID: String) async throws -> [SQUserLevelData]
}

struct SQHomeNetworkService: SQHomeNetworkServiceProtocol {
    func fetchSections() async throws -> [SQSection] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("sections").getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: SQSection.self) }
    }

    func fetchLevels() async throws -> [SQLevel] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("levels").getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: SQLevel.self) }
    }
    
    func fetchUserLevelData(for userID: String) async throws -> [SQUserLevelData] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("users").document(userID).collection("levelData").getDocuments()
        return try snapshot.documents.compactMap { try $0.data(as: SQUserLevelData.self) }
    }
}
