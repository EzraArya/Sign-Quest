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
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    private var firestoreListener: ListenerRegistration?
    
    public init() {
        addAuthStateListener()
    }
    
    private func addAuthStateListener() {
        if authStateHandler != nil { return }
        
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            self.authUser = user
            
            if let user = user {
                self.setupFirestoreListener(for: user.uid)
            } else {
                self.firestoreListener?.remove()
                self.firestoreListener = nil
                self.firestoreUser = nil
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
                    print("Error listening to user document: \(error)")
                    self.firestoreUser = nil
                    return
                }
                
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
    }
    
    public func signOut() {
        if let authStateHandler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(authStateHandler)
            self.authStateHandler = nil
        }
        
        self.firestoreListener?.remove()
        self.firestoreListener = nil
        try? Auth.auth().signOut()
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
