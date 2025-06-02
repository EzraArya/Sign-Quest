//
//  SQRegistrationEmailPage.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQRegistrationEmailPage: View {
    @Binding var email: String
    @Binding var isValid: Bool
    @State private var hasError: Bool = false
    @State private var errorMessage: String = ""
    @FocusState private var isEmailActive: Bool
    @State private var emailStyle: SQTextFieldStyle = .default
    
    public init(email: Binding<String>, isValid: Binding<Bool>) {
        self._email = email
        self._isValid = isValid
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            SQText(
                text: "What is your email address?",
                font: .bold,
                color: .secondary,
                size: 20
            )
            
            SQTextField(
                title: "Email",
                text: $email,
                placeholderText: "Enter your Email",
                style: emailStyle
            )
            .focused($isEmailActive)
            .onChange(of: isEmailActive) { isActive in
                emailStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isActive, hasError: hasError)
            }
            .onChange(of: email) { _ in validateInput() }
            if hasError {
                SQText(
                    text: errorMessage,
                    font: .regular,
                    color: .error,
                    size: 14
                )
            }
            
            Spacer()
        }
    }
    
    private func validateInput() {
        let validation = SQValidationUtil.validateEmail(email)
        hasError = !validation.isValid
        errorMessage = validation.errorMessage
        isValid = validation.isValid
        
        emailStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isEmailActive, hasError: hasError)
    }
}
