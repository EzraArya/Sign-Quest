//
//  UserManager.swift
//  SignQuestCore
//
//  Created by Ezra Arya Wijaya on 06/06/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine
import SignQuestModels

@MainActor
public class UserManager: ObservableObject {
    
    @Published public var authUser: FirebaseAuth.User?
    @Published public var firestoreUser: SQUser?
    @Published public var profileImageUrl: String?
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    private var firestoreListener: ListenerRegistration?
    
    public init() {
        self.authUser = Auth.auth().currentUser
        print("🏁 UserManager initialized with user: \(self.authUser?.uid ?? "nil")")
        
        addAuthStateListener()
        
        if let currentUser = Auth.auth().currentUser {
            setupFirestoreListener(for: currentUser.uid)
        }
    }
    
    private func addAuthStateListener() {
        if authStateHandler != nil { return }
        
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            
            Task { @MainActor in
                print("🔄 Auth state listener triggered:")
                print("   Previous user: \(self.authUser?.uid ?? "nil")")
                print("   New user: \(user?.uid ?? "nil")")
                
                self.authUser = user
                
                if let user = user {
                    print("✅ User authenticated: \(user.uid)")
                    print("   Email: \(user.email ?? "No email")")
                    print("   Email verified: \(user.isEmailVerified)")
                    self.setupFirestoreListener(for: user.uid)
                } else {
                    print("❌ User not authenticated")
                    self.firestoreListener?.remove()
                    self.firestoreListener = nil
                    self.firestoreUser = nil
                    self.profileImageUrl = nil
                }
            }
        }
    }
    
    private func setupFirestoreListener(for uid: String) {
        let db = Firestore.firestore()
        
        self.firestoreListener?.remove()
        
        self.firestoreListener = db.collection("users").document(uid).addSnapshotListener { [weak self] document, error in
            guard let self = self else { return }
            
            Task { @MainActor in
                if let error = error {
                    print("❌ Error listening to user document: \(error)")
                    self.firestoreUser = nil
                    self.profileImageUrl = nil
                    return
                }
                
                if let document = document, document.exists {
                    do {
                        let newUser = try document.data(as: SQUser.self)
                        
                        // Check if image URL has changed
                        let oldImageUrl = self.firestoreUser?.image
                        let newImageUrl = newUser.image
                        
                        if oldImageUrl != newImageUrl {
                            print("📸 Profile image updated:")
                            print("   Old URL: \(oldImageUrl ?? "nil")")
                            print("   New URL: \(newImageUrl ?? "nil")")
                            self.profileImageUrl = newImageUrl
                        }
                        
                        self.firestoreUser = newUser
                        print("✅ Firestore user data loaded")
                    } catch {
                        print("❌ Error decoding user data: \(error)")
                    }
                } else {
                    print("⚠️ User document does not exist")
                    self.firestoreUser = nil
                    self.profileImageUrl = nil
                }
            }
        }
    }
    
    // Method to update profile image URL in Firestore
    public func updateProfileImage(url: String) async throws {
        guard let uid = authUser?.uid else {
            throw UserManagerError.notAuthenticated
        }
        
        let db = Firestore.firestore()
        
        do {
            try await db.collection("users").document(uid).updateData([
                "image": url,
                "updatedAt": FieldValue.serverTimestamp()
            ])
            print("✅ Profile image URL updated in Firestore: \(url)")
        } catch {
            print("❌ Failed to update profile image URL: \(error)")
            throw UserManagerError.updateFailed(error)
        }
    }
    
    // Method to remove profile image
    public func removeProfileImage() async throws {
        guard let uid = authUser?.uid else {
            throw UserManagerError.notAuthenticated
        }
        
        let db = Firestore.firestore()
        
        do {
            try await db.collection("users").document(uid).updateData([
                "image": FieldValue.delete(),
                "updatedAt": FieldValue.serverTimestamp()
            ])
            print("✅ Profile image removed from Firestore")
        } catch {
            print("❌ Failed to remove profile image: \(error)")
            throw UserManagerError.updateFailed(error)
        }
    }
    
    public var isAuthenticated: Bool {
        return authUser != nil
    }
    
    public func signOut() {
        if let authStateHandler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(authStateHandler)
            self.authStateHandler = nil
        }
        
        self.firestoreListener?.remove()
        self.firestoreListener = nil
        
        do {
            try Auth.auth().signOut()
            print("✅ User signed out successfully")
        } catch {
            print("❌ Error signing out: \(error)")
        }
        
        addAuthStateListener()
    }
    
    public func deleteAccount() async {
        guard let user = authUser else { return }
        let db = Firestore.firestore()
        
        do {
            try await db.collection("users").document(user.uid).delete()
            try await user.delete()
        } catch {
            print("Error deleting account: \(error)")
        }
    }
}

// MARK: - Error Handling
public enum UserManagerError: Error, LocalizedError {
    case notAuthenticated
    case updateFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "User is not authenticated"
        case .updateFailed(let error):
            return "Update failed: \(error.localizedDescription)"
        }
    }
}
