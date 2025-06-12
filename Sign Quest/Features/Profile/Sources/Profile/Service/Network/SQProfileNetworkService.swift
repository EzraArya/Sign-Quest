//
//  SQProfileNetworkService.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 06/05/25.
//

import SignQuestModels
import SignQuestCore
import FirebaseAuth
import FirebaseFirestore
import UIKit

protocol SQProfileNetworkServiceProtocol: Sendable {
    func updateProfile(userId: String, profile: SQUser) async throws
    func updatePassword(password: String) async throws
    func uploadProfilePicture(userId: String, image: UIImage) async throws
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
    
    func uploadProfilePicture(userId: String, image: UIImage) async throws {
        let cloudinaryService = CloudinaryService.shared
        let db = Firestore.firestore()
        
        let imageUrl = try await cloudinaryService.uploadProfileImage(image, userId: userId)
        let userDocRef = db.collection("users").document(userId)
        
        try await userDocRef.updateData([
            "image": imageUrl
        ])
    }
}
