//
//  SQAlert.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI

public struct SQAlert: View {
    public var title: String
    public var message: String
    public var primaryButtonTitle: String
    public var secondaryButtonTitle: String
    public var primaryButtonAction: () -> Void
    public var secondaryButtonAction: () -> Void
    
    public init(title: String, message: String, primaryButtonTitle: String, secondaryButtonTitle: String, primaryButtonAction: @escaping () -> Void, secondaryButtonAction: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonAction = secondaryButtonAction
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .center, spacing: 8) {
                SQText(text: title, font: .bold, color: .text, size: 18)
                SQText(text: message, font: .regular, color: .placeholder, size: 16)
                    .multilineTextAlignment(.center)
            }
            SQButton(text: primaryButtonTitle, font: .bold, style: .danger, size: 16, action: primaryButtonAction)
            SQButton(text: secondaryButtonTitle, font: .bold, style: .muted, size: 16, action: secondaryButtonAction)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(SQColor.alertBackground.color)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(SQColor.error.color, lineWidth: 2)
        )
    }
}
