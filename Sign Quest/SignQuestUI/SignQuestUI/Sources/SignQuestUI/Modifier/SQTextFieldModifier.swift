//
//  SQTextFieldModifier.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI

struct SQTextFieldModifier: ViewModifier {
    let font: SQFont
    let size: CGFloat
    let style: SQTextFieldStyle
    let cornerRadius: CGFloat
    let padding: EdgeInsets
    let keyboardType: UIKeyboardType
    
    func body(content: Content) -> some View {
        content
            .font(font.font(size: size))
            .foregroundColor(style.textColor.color)
            .accentColor(style.textColor.color)
            .padding(padding)
            .background(style.backgroundColor.color)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(style.borderColor.color, lineWidth: 1)
            )
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .autocorrectionDisabled()
    }
}
