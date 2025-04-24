//
//  SQLeaderboardView.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 24/04/25.
//

import SwiftUI
import SignQuestUI

struct Player: Identifiable {
    let id = UUID()
    let name: String
    let score: Int
    let avatar: String // asset name or URL
}

public struct SQLeaderboardView: View {
    let coordinator: SQLeaderboardCoordinator
    
    let players: [Player] = [
        Player(name: "Alice", score: 150, avatar: "person"),
        Player(name: "Bob", score: 140, avatar: "person"),
        Player(name: "Charlie", score: 130, avatar: "person"),
        Player(name: "David", score: 120, avatar: "person"),
        Player(name: "Eve", score: 110, avatar: "person")
    ]
    
    public init(coordinator: SQLeaderboardCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        ScrollView {
            SQText(text: "Leaderboard", font: .bold, color: .secondary, size: 24)

            VStack(spacing: 32) {
                if players.count >= 3 {
                    SQPodiumView(players: Array(players.prefix(3)))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(players.dropFirst(3).enumerated().map({ $0 }), id: \.element.id) { index, player in
                        HStack {
                            SQText(text: "\(index + 4). \(player.name)", font: .medium, color: .text, size: 12)
                            Spacer()
                            SQText(text: "\(player.score)", font: .bold, color: .text, size: 12)
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
    }
        
    @ViewBuilder
    func SQPodiumView(players: [Player]) -> some View {
        let podiumOrder = [1, 0, 2]
        
        HStack(alignment: .bottom, spacing: 16) {
            ForEach(podiumOrder, id: \.self) { i in
                let player = players[i]
                let height: CGFloat = {
                    switch i {
                    case 0: return 160
                    case 1: return 130
                    case 2: return 120
                    default: return 100
                    }
                }()
                
                VStack {
                    Image(systemName: player.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    SQText(text: player.name, font: .medium, color: .text, size: 12)
                    SQText(text: "\(player.score)", font: .bold, color: .complementary, size: 16)

                    Rectangle()
                        .fill(i == 0 ? SQColor.accent.color  : SQColor.primary.color)
                        .frame(height: height)
                        .cornerRadius(12)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
}

