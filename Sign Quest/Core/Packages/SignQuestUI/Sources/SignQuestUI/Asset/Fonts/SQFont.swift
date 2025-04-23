//
//  SQFont.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 21/04/25.
//

import SwiftUI

public enum SQFont {
    case bold
    case light
    case medium
    case regular
    case semiBold
    case custom(String, CGFloat)
    
    public func font(size: CGFloat) -> Font {
        switch self {
        case .bold:
            return .custom("Inter-Bold", size: size)
        case .light:
            return .custom("Inter-Light", size: size)
        case .medium:
            return .custom("Inter-Medium", size: size)
        case .regular:
            return .custom("Inter-Regular", size: size)
        case .semiBold:
            return .custom("Inter-SemiBold", size: size)
        case .custom(let name, let size):
            return .custom(name, size: size)
        }
    }
}
