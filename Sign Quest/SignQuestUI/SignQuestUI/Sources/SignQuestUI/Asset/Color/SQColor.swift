//
//  SQColor.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 21/04/25.
//
import SwiftUI

public enum SQColor {
    case primary
    case secondary
    case accent
    case background
    case text
    case placeholder
    case error
    case textbox
    case trackbar
    case complementary
    case muted
    case line
    case defaultBorder
    
    public var color: Color {
        switch self {
        case .primary:
            return Color("Primary", bundle: .module)
        case .secondary:
            return Color("Secondary", bundle: .module)
        case .accent:
            return Color("Accent", bundle: .module)
        case .background:
            return Color("Background", bundle: .module)
        case .text:
            return Color("Text", bundle: .module)
        case .placeholder:
            return Color("Placeholder", bundle: .module)
        case .error:
            return Color("Error", bundle: .module)
        case .textbox:
            return Color("Textbox", bundle: .module)
        case .trackbar:
            return Color("Trackbar", bundle: .module)
        case .complementary:
            return Color("Complementary", bundle: .module)
        case .muted:
            return Color("Muted", bundle: .module)
        case .line:
            return Color("Line", bundle: .module)
        case .defaultBorder:
            return Color("Default-Border", bundle: .module)
        }
    }
}
