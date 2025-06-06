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
    func login(email: String, password: String) async throws -> User
    func register(user: SQUser, password: String) async throws -> SQUser
}

struct SQAuthenticationNetworkService: SQAuthenticationNetworkServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func login(email: String, password: String) async throws -> User {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return authResult.user
    }
    
    func register(user: SQUser, password: String) async throws -> SQUser {
        let authResult = try await Auth.auth().createUser(withEmail: user.email, password: password)
        let uid = authResult.user.uid
        
        var userToSave = user
        userToSave.id = uid

        try db.collection("users").document(uid).setData(from: userToSave)
        return userToSave
    }
}
