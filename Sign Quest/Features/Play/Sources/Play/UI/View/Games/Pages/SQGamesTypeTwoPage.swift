//
//  SQGamesTypeTwoPage.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQGamesTypeTwoPage: View {
    let promptText: String
    let answerOptions: [String]
    let onAnswerSelected: (Int) -> Void
    
    public init(
        promptText: String,
        answerOptions: [String],
        onAnswerSelected: @escaping (Int) -> Void
    ) {
        self.promptText = promptText
        self.answerOptions = answerOptions
        self.onAnswerSelected = onAnswerSelected
    }

    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SQText(
                    text: "Select the correct",
                    font: .bold,
                    color: .text,
                    size: 24
                )
                SQText(
                    text: "Gesture",
                    font: .bold,
                    color: .primary,
                    size: 24
                )
            }

            Spacer()

            VStack(spacing: 36){
                SQText(text: promptText, font: .bold, color: .secondary, size: 64)
                
                SQAnswerGridView(
                    answerOptions: answerOptions,
                    onAnswerSelected: onAnswerSelected,
                    isImage: true
                )
            }
            Spacer()
            Spacer()
        }
        .applyBackground()
        .toolbar(.hidden, for: .tabBar)
    }
}
