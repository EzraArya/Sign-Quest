//
//  SQBackgroundModifier.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI

public struct SQBackgroundModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(SQColor.background.color
                .ignoresSafeArea()
            )
    }
}
