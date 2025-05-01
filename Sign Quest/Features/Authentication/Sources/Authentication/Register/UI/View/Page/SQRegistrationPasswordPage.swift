//
//  SQRegistrationPasswordPage.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQRegistrationPasswordPage: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var isValid: Bool
    @State private var hasError: Bool = false
    @State private var errorMessage: String = ""
    @FocusState private var isPasswordActive: Bool
    @FocusState private var isConfirmPasswordActive: Bool
    @State private var passwordStyle: SQTextFieldStyle = .default
    @State private var confirmPasswordStyle: SQTextFieldStyle = .default

    
    public init(password: Binding<String>, confirmPassword: Binding<String>, isValid: Binding<Bool>) {
        self._password = password
        self._confirmPassword = confirmPassword
        self._isValid = isValid
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            SQText(
                text: "Create a password",
                font: .bold,
                color: .secondary,
                size: 20
            )
            
            VStack(alignment: .leading, spacing: 16) {
                SQTextField(
                    title: "Password",
                    text: $password,
                    placeholderText: "Password",
                    style: passwordStyle,
                    isSecure: true
                )
                .focused($isPasswordActive)
                .onChange(of: isPasswordActive) { isActive in
                    passwordStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isPasswordActive, hasError: hasError)
                }
                .onChange(of: password) { _ in validateInput() }

                
                SQTextField(
                    title: "Confirm Password",
                    text: $confirmPassword,
                    placeholderText: "Confirm password",
                    style: confirmPasswordStyle,
                    isSecure: true
                )
                .focused($isConfirmPasswordActive)
                .onChange(of: isConfirmPasswordActive) { isActive in
                    confirmPasswordStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isPasswordActive, hasError: hasError)
                }
                .onChange(of: confirmPassword) { _ in validateInput() }
            }
            
            Spacer()
        }
    }
    
    private func validateInput() {
        let validation = SQValidationUtil.validatePassword(password: password, confirmPassword: confirmPassword)
        hasError = !validation.isValid
        errorMessage = validation.errorMessage
        isValid = validation.isValid
        
        passwordStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isPasswordActive, hasError: hasError)
        confirmPasswordStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isConfirmPasswordActive, hasError: hasError)

    }

}
