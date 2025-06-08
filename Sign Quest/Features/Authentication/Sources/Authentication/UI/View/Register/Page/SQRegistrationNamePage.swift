//
//  SQRegistrationNamePage.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQRegistrationNamePage: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var isValid: Bool
    @State private var hasError: Bool = false
    @State private var errorMessage: String = ""
    @FocusState private var isFirstNameActive: Bool
    @FocusState private var isLastNameActive: Bool
    @State private var firstNameStyle: SQTextFieldStyle = .default
    @State private var lastNameStyle: SQTextFieldStyle = .default

    
    public init(firstName: Binding<String>, lastName: Binding<String>, isValid: Binding<Bool>) {
        self._firstName = firstName
        self._lastName = lastName
        self._isValid = isValid
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            SQText(
                text: "What's your name?",
                font: .bold,
                color: .secondary,
                size: 24
            )
            
            VStack(alignment: .leading, spacing: 16) {
                SQTextField(
                    title: "First name",
                    text: $firstName,
                    placeholderText: "First name",
                    style: firstNameStyle
                )
                .focused($isFirstNameActive)
                .onChange(of: isFirstNameActive) { isActive in
                    firstNameStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isFirstNameActive, hasError: hasError)
                }
                .onChange(of: firstName) { _ in validateInput() }
                
                SQTextField(
                    title: "Last name",
                    text: $lastName,
                    placeholderText: "Last name",
                    style: lastNameStyle
                )
                .focused($isLastNameActive)
                .onChange(of: isLastNameActive) { isActive in
                    lastNameStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isLastNameActive, hasError: hasError)
                }
                .onChange(of: lastName) { _ in validateInput() }

                if hasError {
                    SQText(
                        text: errorMessage,
                        font: .regular,
                        color: .error,
                        size: 14
                    )
                }
            }
            
            Spacer()
        }
    }
    
    private func validateInput() {
        let validation = SQValidationUtil.validateName(firstName: firstName, lastName: lastName)
        hasError = !validation.isValid
        errorMessage = validation.errorMessage
        isValid = validation.isValid
        
        firstNameStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isFirstNameActive, hasError: firstName.isEmpty)
            
        lastNameStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isLastNameActive, hasError: lastName.isEmpty)
    }
}
