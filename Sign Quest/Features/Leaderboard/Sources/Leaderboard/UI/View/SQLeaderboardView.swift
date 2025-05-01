//
//  SQLeaderboardView.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestUI
import SignQuestModels

public struct SQLeaderboardView: View {
    @EnvironmentObject var coordinator: SQLeaderboardCoordinator
    @StateObject var viewModel: SQLeaderboardViewModel = SQLeaderboardViewModel()
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            SQText(text: "Leaderboard", font: .bold, color: .secondary, size: 24)
            
            VStack(spacing: 32) {
                if viewModel.leaderboardData.count >= 3 {
                    SQPodiumView(players: Array(viewModel.leaderboardData.prefix(3)))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.leaderboardData.dropFirst(3).enumerated().map({ $0 }), id: \.element.id) { index, player in
                        HStack {
                            SQText(text: "\(index + 4). \(player.firstName)", font: .medium, color: .text, size: 12)
                            Spacer()
                            SQText(text: "\(player.totalScore)", font: .bold, color: .text, size: 12)
                        }
                        .padding()
                        .applyBackground()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(SQColor.accent.color, lineWidth: 2)
                        )
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .applyBackground()
        .task {
            await viewModel.fetchLeaderboardData()
        }
    }
}
