//
//  SQGamesTypeOnePage.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQGamesTypeOnePage: View {
    let promptImage: String
    let answerOptions: [String]
    let onAnswerSelected: (Int) -> Void
    
    public init(
        promptImage: String,
        answerOptions: [String],
        onAnswerSelected: @escaping (Int) -> Void
    ) {
        self.promptImage = promptImage
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
                    text: "Alphabet",
                    font: .bold,
                    color: .primary,
                    size: 24
                )
            }
            
            Spacer()
            
            VStack(spacing: 36) {
                SQImage(image: promptImage, width: 64, height: 64, color: .cream)
                    .frame(alignment: .center)
                
                SQAnswerGridView(
                    answerOptions: answerOptions,
                    onAnswerSelected: onAnswerSelected
                )
            }
            
            Spacer()
            Spacer()
        }
        .applyBackground()
        .toolbar(.hidden, for: .tabBar)
    }
}
