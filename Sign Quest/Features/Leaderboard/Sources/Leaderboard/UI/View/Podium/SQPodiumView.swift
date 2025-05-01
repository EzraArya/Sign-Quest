//
//  SQPodiumView.swift
//  Leaderboard
//
//  Created by Ezra Arya Wijaya on 02/05/25.
//

import SwiftUI
import SignQuestUI
import SignQuestModels

public struct SQPodiumView: View {
    let players: [SQUser]
    
    public init(players: [SQUser]) {
        self.players = players
    }
    
    public var body: some View {
        let podiumOrder = [1, 0, 2] // 2nd, 1st, 3rd places
        
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(0..<min(podiumOrder.count, players.count), id: \.self) { i in
                PodiumItem(player: players[podiumOrder[i]], position: podiumOrder[i])
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func PodiumItem(player: SQUser, position: Int) -> some View {
        let height: CGFloat = heightForPosition(position)
        let podiumIconName = iconNameForPosition(position)
        let podiumIconColor = colorForPosition(position)
        
        VStack {
            PlayerAvatarView(player: player, borderColor: podiumIconColor)
            
            SQText(text: player.firstName, font: .medium, color: .text, size: 12)
            SQText(text: "\(player.totalScore)", font: .bold, color: .complementary, size: 16)
            
            PodiumBase(position: position, height: height, podiumIconName: podiumIconName, podiumIconColor: podiumIconColor)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func PlayerAvatarView(player: SQUser, borderColor: Color) -> some View {
        if let uiImage = UIImage(named: "ayame", in: .module, compatibleWith: nil) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(borderColor, lineWidth: 2)
                )
        } else {
            Image(systemName: player.image ?? "person")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(borderColor, lineWidth: 2)
                )
        }
    }
    
    @ViewBuilder
    private func PodiumBase(position: Int, height: CGFloat, podiumIconName: String, podiumIconColor: Color) -> some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(position == 0 ? SQColor.accent.color : SQColor.primary.color)
                .frame(height: height)
                .clipShape(
                    RoundedCorners(
                        topLeft: position == 0 || position == 1 ? 8 : 0,
                        topRight: position == 0 || position == 2 ? 8 : 0,
                        bottomLeft: position == 1 ? 8 : 0,
                        bottomRight: position == 2 ? 8 : 0
                    )
                )
            
            Image(systemName: podiumIconName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(podiumIconColor)
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
                .padding(.top, 8)
        }
    }
    
    private func heightForPosition(_ position: Int) -> CGFloat {
        switch position {
        case 0: return 160
        case 1: return 130
        case 2: return 100
        default: return 100
        }
    }
    
    private func iconNameForPosition(_ position: Int) -> String {
        switch position {
        case 0: return "1.circle"
        case 1: return "2.circle"
        case 2: return "3.circle"
        default: return "person"
        }
    }
    
    private func colorForPosition(_ position: Int) -> Color {
        switch position {
        case 0: return SQColor.complementary.color
        case 1: return SQColor.blue.color
        case 2: return SQColor.green.color
        default: return SQColor.primary.color
        }
    }
}

struct RoundedCorners: Shape {
    var topLeft: CGFloat = 0
    var topRight: CGFloat = 0
    var bottomLeft: CGFloat = 0
    var bottomRight: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Top left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        if topLeft > 0 {
            path.addArc(center: CGPoint(x: rect.minX + topLeft, y: rect.minY + topLeft),
                      radius: topLeft,
                      startAngle: Angle(degrees: 180),
                      endAngle: Angle(degrees: 270),
                      clockwise: false)
        }
        
        // Top right
        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        if topRight > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - topRight, y: rect.minY + topRight),
                      radius: topRight,
                      startAngle: Angle(degrees: 270),
                      endAngle: Angle(degrees: 0),
                      clockwise: false)
        }
        
        // Bottom right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        if bottomRight > 0 {
            path.addArc(center: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY - bottomRight),
                      radius: bottomRight,
                      startAngle: Angle(degrees: 0),
                      endAngle: Angle(degrees: 90),
                      clockwise: false)
        }
        
        // Bottom left
        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        if bottomLeft > 0 {
            path.addArc(center: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY - bottomLeft),
                      radius: bottomLeft,
                      startAngle: Angle(degrees: 90),
                      endAngle: Angle(degrees: 180),
                      clockwise: false)
        }
        
        path.closeSubpath()
        return path
    }
}
