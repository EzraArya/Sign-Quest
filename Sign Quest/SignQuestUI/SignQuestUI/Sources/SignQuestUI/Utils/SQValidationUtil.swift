//
//  SQValidationUtil.swift
//  Sign Quest
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import Foundation

public struct SQValidationUtil {
    public static func validateAge(_ age: String) -> (isValid: Bool, errorMessage: String) {
        guard !age.isEmpty else {
            return (false, "Age is required")
        }
        
        guard let ageInt = Int(age) else {
            return (false, "Age must be a number")
        }
        
        return (ageInt >= 13 && ageInt <= 120, "Please enter a valid age (13-120)")
    }
    
    public static func validateName(firstName: String, lastName: String) -> (isValid: Bool, errorMessage: String) {
        if firstName.isEmpty || lastName.isEmpty {
            return (false, "Please enter your full name")
        }
        
        return (true, "")
    }
    
    public static func validateEmail(_ email: String) -> (isValid: Bool, errorMessage: String) {
        guard !email.isEmpty else {
            return (false, "Email is required")
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailPredicate.evaluate(with: email)
        
        return (isValid, isValid ? "" : "Please enter a valid email address")
    }
    
    public static func validatePassword(password: String, confirmPassword: String) -> (isValid: Bool, errorMessage: String) {
        guard !password.isEmpty else {
            return (false, "Password is required")
        }
        
        guard password.count >= 8 else {
            return (false, "Password must be at least 8 characters")
        }
        
        if !confirmPassword.isEmpty && password != confirmPassword {
            return (false, "Passwords do not match")
        }
        
        return (true, "")
    }
}
