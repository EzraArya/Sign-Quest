//
//  UserDefaultManager.swift
//  Sign Quest
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import Foundation

public final class UserDefaultsManager: @unchecked Sendable {
    public static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    private let onboardingKey = "SQ_isOnboardingCompleted"
    private let loginKey = "SQ_isLoggedIn"
    
    public var isOnboardingCompleted: Bool {
        get { defaults.bool(forKey: onboardingKey) }
        set {
            defaults.set(newValue, forKey: onboardingKey)
        }
    }
    
    public var isLoggedIn: Bool {
        get { defaults.bool(forKey: loginKey) }
        set {
            defaults.set(newValue, forKey: loginKey)
            defaults.synchronize()
        }
    }
    
    public func resetAll() {
        isOnboardingCompleted = false
        isLoggedIn = false
    }
}
