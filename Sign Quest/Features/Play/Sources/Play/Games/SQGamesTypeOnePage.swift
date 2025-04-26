//
//  SQGamesTypeOnePage.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQGamesTypeOnePage: View {
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
                    text: "Alphabet",
                    font: .bold,
                    color: .primary,
                    size: 24
                )
            }
            
            Spacer()
            
            VStack(spacing: 36) {
                SQImage(image: "hand.raised.fill", width: 64, height: 64, color: .cream)
                    .frame(alignment: .center)
                
                SQAnswerGridView(
                    answerOptions: ["A", "B", "C", "D"],
                    onAnswerSelected: { index in
                        print("Selected answer index: \(index)")
                    }
                )
            }
            
            Spacer()
            Spacer()
        }
        .applyBackground()
        .toolbar(.hidden, for: .tabBar)
    }
}
