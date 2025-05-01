//
//  SQScoreView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQScoreView: View {
    @EnvironmentObject var coordinator: SQPlayCoordinator

    public init() {}
    
    public var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .center, spacing: 8) {
                SQText(text: "🥳", font: .bold, color: .text, size: 76)
                SQText(text: "Your Score", font: .bold, color: .text, size: 24)
                SQText(text: "1000", font: .bold, color: .complementary, size: 32)
            }
            
            Spacer()
            
            SQButton(text: "Continue", font: .bold, style: .default, size: 16) {
                coordinator.navigateToHome()
            }
        }
        .padding(.horizontal, 24)
        .applyBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}
