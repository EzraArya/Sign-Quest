//
//  SQTextField.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import Combine

public enum SQTextFieldStyle {
    case `default`
    case inactive
    case focused
    case error
    
    var textColor: SQColor {
        switch self {
        case .default, .inactive, .error:
            return .placeholder
        case .focused:
            return .text
        }
    }
        
    var backgroundColor: SQColor {
        switch self {
        case .default, .inactive, .focused, .error:
            return .textbox
        }
    }
    
    var borderColor: SQColor {
        switch self {
        case .default:
            return .secondary
        case .inactive:
            return .muted
        case .focused:
            return .accent
        case .error:
            return .error
        }
    }
}

        
public struct SQTextField: View {
    private var title: String
    @Binding private var text: String
    private var placeholderText: String
    private var font: SQFont
    private var size: CGFloat
    private var style: SQTextFieldStyle
    private var cornerRadius: CGFloat
    private var padding: EdgeInsets
    private var isSecure: Bool
    private var keyboardType: UIKeyboardType
    private var placeholderColor: SQColor {
        return .placeholder
    }
    
    public init(
        title: String,
        text: Binding<String>,
        placeholderText: String,
        font: SQFont = .regular,
        size: CGFloat = 16,
        style: SQTextFieldStyle = .default,
        cornerRadius: CGFloat = 6,
        padding: EdgeInsets = EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16),
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default
    ) {
        self.title = title
        self._text = text
        self.placeholderText = placeholderText
        self.font = font
        self.size = size
        self.style = style
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.isSecure = isSecure
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        if isSecure {
            SecureField(title,
                        text: $text,
                        prompt: Text(placeholderText)
                .foregroundColor(placeholderColor.color)
            )
                .applyTextFieldModifiers(
                    font: font,
                    size: size,
                    style: style,
                    cornerRadius: cornerRadius,
                    padding: padding,
                    keyboardType: keyboardType
                )
                .frame(maxWidth: .infinity)
        } else {
            TextField(title,
                      text: $text,
                      prompt: Text(placeholderText)
              .foregroundColor(placeholderColor.color)
            )
                .applyTextFieldModifiers(
                    font: font,
                    size: size,
                    style: style,
                    cornerRadius: cornerRadius,
                    padding: padding,
                    keyboardType: keyboardType
                )
                .frame(maxWidth: .infinity)
        }
    }
}

extension SQTextField {
    public mutating func determineStyle(isActive: Bool, hasError: Bool) {
        if hasError {
            self.style = .error
        } else if isActive {
            self.style = .focused
        } else {
            self.style = .default
        }
    }
}
