//
//  SQProfileNetworkService.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 06/05/25.
//

import SignQuestModels
import FirebaseAuth
import FirebaseFirestore

protocol SQProfileNetworkServiceProtocol: Sendable {
    func updateProfile(userId: String, profile: SQUser) async throws
    func updatePassword(password: String) async throws
}

struct SQProfileNetworkService: SQProfileNetworkServiceProtocol {
    func updateProfile(userId: String, profile: SQUser) async throws {
        let db = Firestore.firestore()
        
        let userDocRef = db.collection("users").document(userId)
        try userDocRef.setData(from: profile, merge: true)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "User not authenticated", code: 401, userInfo: nil)
        }
        
        try await user.updatePassword(to: password)
    }
}
