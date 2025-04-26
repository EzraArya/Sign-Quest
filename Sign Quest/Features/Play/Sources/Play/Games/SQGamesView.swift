//
//  SQGamesView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQGamesView: View {
    @EnvironmentObject var coordinator: SQPlayCoordinator
    @State private var currentTab: Int = 0
    @State private var progressAmount: Double = 25.0
    
    public init() {}
    
    public var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape")
                        .bold()
                        .foregroundColor(SQColor.secondary.color)
                }
                
                Spacer()
                
                SQProgressBar(progress: $progressAmount)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 8)
            
            TabView(selection: $currentTab) {
                SQGamesTypeOnePage()
                    .tag(0)
                SQGamesTypeTwoPage()
                    .tag(1)
                SQGamesTypeThreePage()
                    .tag(2)
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            SQButton(text: "Check", font: .bold, style: .muted, size: 16) {
                progressAmount += 25
                currentTab += 1
                
                if progressAmount >= 100 {
                    coordinator.push(.finish)
                }
            }
            .padding(.horizontal, 24)
        }
        .applyBackground()
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}
