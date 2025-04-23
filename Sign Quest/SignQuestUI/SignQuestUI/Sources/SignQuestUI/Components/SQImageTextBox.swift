//
//  SQImageTextBox.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI

public struct SQImageTextBox: View {
    var image: String
    var imageColor: SQColor
    var title: String
    var description: String

    public init(image: String, imageColor: SQColor, title: String, description: String) {
        self.image = image
        self.imageColor = imageColor
        self.title = title
        self.description = description
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 8) {
            SQImage(image: image, color: imageColor)
            VStack(alignment: .leading, spacing: 2) {
                SQText(text: title, font: .regular, color: .text, size: 16)
                SQText(text: description, font: .regular, color: .text, size: 12)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(SQColor.primary.color, lineWidth: 2)
        )
    }
}
