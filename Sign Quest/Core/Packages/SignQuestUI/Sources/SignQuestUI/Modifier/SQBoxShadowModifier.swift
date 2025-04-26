//
//  SQBoxShadowModifier.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI

public struct SQBoxShadowModifier: ViewModifier {
    var color: Color
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.3), radius: 0, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(color.opacity(0.3), lineWidth: 1)
                    .offset(x: 0, y: 4)
                    .blur(radius: 0)
                    .mask(content)
            )
    }
}
