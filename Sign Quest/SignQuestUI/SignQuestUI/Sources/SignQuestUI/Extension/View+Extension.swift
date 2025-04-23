//
//  View+Extension.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI

public extension View {
    func applyBackground() -> some View {
        self.modifier(SQBackgroundModifier())
    }
    
    func applyTextFieldModifiers(
        font: SQFont,
        size: CGFloat,
        style: SQTextFieldStyle,
        cornerRadius: CGFloat,
        padding: EdgeInsets,
        keyboardType: UIKeyboardType
    ) -> some View {
        self.modifier(
            SQTextFieldModifier(
                font: font,
                size: size,
                style: style,
                cornerRadius: cornerRadius,
                padding: padding,
                keyboardType: keyboardType
            )
        )
    }
    
    func withNavigation(path: Binding<NavigationPath>) -> some View {
        NavigationStack(path: path) {
            self
        }
    }
}
