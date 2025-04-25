//
//  SQHomeView.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQHomeView: View {
    @EnvironmentObject var coordinator: SQHomeCoordinator
    public var user: String = "User"
    
    public init() {}
    
    public var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    SQText(text: "Welcome,", font: .bold, color: .secondary, size: 24)
                    SQText(text: user, font: .bold, color: .primary, size: 24)
                }
                
                SQBanner(section: "Section 1", title: "Alphabet")
                                
                VStack(spacing: 30) {
                    SQLevelButton(level: "1", style: .completed)
                    SQLevelButton(level: "2")
                    SQLevelButton(level: "3", style: .locked)
                    SQLevelButton(level: "4", style: .locked)
                    SQLevelButton(level: "5", style: .locked)
                }
                .padding(.top, 36)
                .padding(.horizontal, 12)
                
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(. horizontal, 24)
        .padding(.top, 16)
        .applyBackground()
    }
}
