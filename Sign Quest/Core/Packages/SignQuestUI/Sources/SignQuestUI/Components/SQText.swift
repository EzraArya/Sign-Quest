//
//  SQText.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 21/04/25.
//

import SwiftUI

public struct SQText: View {
    public var text: String
    public var font: SQFont
    public var color: SQColor
    public var size: CGFloat
    
    public init(text: String, font: SQFont, color: SQColor, size: CGFloat) {
        self.text = text
        self.font = font
        self.color = color
        self.size = size
    }
    
    public var body: some View {
        Text(text)
            .font(font.font(size: size))
            .foregroundColor(color.color)
    }
}
