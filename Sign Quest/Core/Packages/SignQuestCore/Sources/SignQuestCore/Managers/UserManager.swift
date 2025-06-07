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

public class UserManager: ObservableObject {
    
    @Published public var authUser: FirebaseAuth.User?
    @Published public var firestoreUser: SQUser?
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    public init() {
        addAuthStateListener()
    }
    
    private func addAuthStateListener() {
        if authStateHandler != nil { return }
        
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            self.authUser = user
            
            if let user = user {
                self.fetchFirestoreUser(uid: user.uid)
            } else {
                self.firestoreUser = nil
            }
        }
    }
    
    private func fetchFirestoreUser(uid: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let document = document, document.exists {
                do {
                    self.firestoreUser = try document.data(as: SQUser.self)
                } catch {
                    print("Error decoding user data: \(error)")
                }
            } else {
                print("User document does not exist")
                self.firestoreUser = nil
            }
        }
    }
    
    public func signOut() {
        try? Auth.auth().signOut()
    }
    
    public func deleteAccount() {
        guard let user = authUser else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).delete { [weak self] error in
            if let error = error {
                print("Error deleting user document: \(error)")
            } else {
                user.delete()
                self?.authUser = nil
                self?.firestoreUser = nil
            }
        }
    }
    
    deinit {
        if let authStateHandler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(authStateHandler)
        }
    }
}

