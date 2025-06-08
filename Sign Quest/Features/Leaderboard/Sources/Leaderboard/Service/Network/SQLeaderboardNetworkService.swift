//
//  SQLeaderboardNetworkService.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 02/05/25.
//

import SignQuestModels
import FirebaseFirestore

protocol SQLeaderboardNetworkServiceProtocol: Sendable {
    func fetchLeaderboardData() async throws -> [SQUser]
}

struct SQLeaderboardNetworkService: SQLeaderboardNetworkServiceProtocol {
    func fetchLeaderboardData() async throws -> [SQUser] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("users").order(by: "totalScore", descending: true).limit(to: 10).getDocuments()
        
        let users = snapshot.documents.compactMap { document in
            try? document.data(as: SQUser.self)
        }
        
        return users
    }
}
