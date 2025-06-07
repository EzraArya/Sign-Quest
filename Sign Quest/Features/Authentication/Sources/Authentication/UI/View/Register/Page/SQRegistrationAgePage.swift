//
//  SQRegistrationAgePage.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQRegistrationAgePage: View {
    @Binding var age: String
    @Binding var isValid: Bool
    @State private var hasError: Bool = false
    @State private var errorMessage: String = ""
    @FocusState private var isAgeActive: Bool
    @State private var ageStyle: SQTextFieldStyle = .default
    
    public init(age: Binding<String>, isValid: Binding<Bool>) {
        self._age = age
        self._isValid = isValid
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            SQText(
                text: "How old are you?",
                font: .bold,
                color: .secondary,
                size: 20
            )
            
            SQTextField(
                title: "Age",
                text: $age,
                placeholderText: "Enter your age",
                style: ageStyle,
                keyboardType: .numberPad
            )
            .focused($isAgeActive)
            .onChange(of: isAgeActive) { isActive in
                ageStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isActive, hasError: hasError)
            }
            .onChange(of: age) { _ in validateInput() }
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
        let validation = SQValidationUtil.validateAge(age)
        hasError = !validation.isValid
        errorMessage = validation.errorMessage
        isValid = validation.isValid
        
        ageStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isAgeActive, hasError: hasError)
    }
}
