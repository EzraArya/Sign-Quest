//
//  SQLoginViewModel.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import Combine
import SignQuestUI

public class SQLoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailStyle: SQTextFieldStyle = .default
    @Published var passwordStyle: SQTextFieldStyle = .default
    @Published var hasError: Bool = false

    func validateInput(isEmailActive: Bool, isPasswordActive: Bool) {
        hasError = email.isEmpty || password.isEmpty
        emailStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isEmailActive, hasError: email.isEmpty)
        passwordStyle = SQTextFieldUtil.setTextFieldStyle(isActive: isPasswordActive, hasError: password.isEmpty)
    }
}
