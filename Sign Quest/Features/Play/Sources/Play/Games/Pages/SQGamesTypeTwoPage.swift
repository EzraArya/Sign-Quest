//
//  SQGamesTypeTwoPage.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQGamesTypeTwoPage: View {
    
    public init() {}

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
                SQText(text: "A", font: .bold, color: .secondary, size: 64)
                
                SQAnswerGridView(
                    answerOptions: ["hand.raised", "hand.point.left", "hand.draw", "hand.wave"],
                    onAnswerSelected: { index in
                        print("Selected answer index: \(index)")
                    },
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
