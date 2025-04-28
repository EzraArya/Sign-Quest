//
//  SQGamesTypeThreePage.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQGamesTypeThreePage: View {
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                SQText(
                    text: "Perform this",
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
                SQText(text: "A", font: .bold, color: .text, size: 64)
                
                Rectangle()
                    .frame(width: 312, height: 312)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(SQColor.primary.color, lineWidth: 2)
                    )
            }
            
            Spacer()
            Spacer()
        }
        .applyBackground()
        .toolbar(.hidden, for: .tabBar)
    }
}
