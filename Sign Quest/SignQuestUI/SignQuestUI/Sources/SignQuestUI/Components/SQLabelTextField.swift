//
//  SQLabelTextField.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI

public struct SQLabelTextField: View {
    var label: String
    var title: String
    @Binding var text: String
    var placeholder: String
    var isPassword: Bool = false
    
    public init(label: String, title: String, text: Binding<String>, placeholder: String, isPassword: Bool = false) {
        self.label = label
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.isPassword = isPassword
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SQText(text: label, font: .bold, color: .secondary, size: 16)
            SQTextField(title: title, text: $text, placeholderText: placeholder, isSecure: isPassword)
                
        }
        .frame(maxWidth: .infinity)
    }
}

