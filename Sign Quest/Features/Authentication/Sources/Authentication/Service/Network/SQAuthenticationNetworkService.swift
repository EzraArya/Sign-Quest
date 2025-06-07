//
//  SQAuthenticationNetworkService.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 06/06/25.
//

import SignQuestModels
import FirebaseAuth
import FirebaseFirestore

protocol SQAuthenticationNetworkServiceProtocol {
    func login(email: String, password: String) async throws
    func register(user: SQUser, password: String) async throws
}

struct SQAuthenticationNetworkService: SQAuthenticationNetworkServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func login(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func register(user: SQUser, password: String) async throws {
        let authResult = try await Auth.auth().createUser(withEmail: user.email, password: password)
        let uid = authResult.user.uid
        try db.collection("users").document(uid).setData(from: user)
    }
}
