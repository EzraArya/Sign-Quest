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
                
                LevelButton(levelNumber: 1, levelTitle: "Basic Phrases")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(. horizontal, 24)
        .padding(.top, 16)
        .applyBackground()
    }
}
struct LevelButton: View {
    @State private var showPopup = false
    let levelNumber: Int
    let levelTitle: String
    
    var body: some View {
        ZStack {
            // The level button stays fixed at its position
            Button {
                withAnimation(.spring()) {
                    showPopup.toggle()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 70, height: 70)
                        .shadow(radius: 3)
                    
                    Text("\(levelNumber)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            
            // Popup is in an overlay so it doesn't affect button layout
            if showPopup {
                GeometryReader { geometry in
                    ChatboxPopup(levelNumber: levelNumber, levelTitle: levelTitle) {
                        withAnimation(.spring()) {
                            showPopup = false
                        }
                    } startLevel: {
                        print("Starting level \(levelNumber)...")
                        withAnimation(.spring()) {
                            showPopup = false
                        }
                        // Add your logic to start the level here
                    }
                    .position(
                        x: geometry.size.width/2 + 145,
                        y: geometry.size.height/2
                    )
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        // Fixed frame for the button container only
        .frame(width: 70, height: 70)
    }
}

struct ChatboxPopup: View {
    let levelNumber: Int
    let levelTitle: String
    let closeAction: () -> Void
    let startLevel: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            // Triangle pointer
            ChatboxPointer()
                .fill(Color.white)
                .frame(width: 15, height: 20)
                .shadow(color: Color.black.opacity(0.1), radius: 1)
                .zIndex(1)
            
            // Chatbox content
            VStack(spacing: 12) {
                // Header
                HStack {
                    Text("Level \(levelNumber)")
                        .font(.system(size: 18, weight: .bold))
                    
                    Spacer()
                    
                    Button {
                        closeAction()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                
                Text(levelTitle)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                
                Button {
                    startLevel()
                } label: {
                    Text("Start")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 140, height: 40)
                        .background(Color.green)
                        .cornerRadius(20)
                }
                .padding(.top, 5)
            }
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
            )
            .frame(width: 200)
        }
    }
}

// Custom shape for chatbox pointer - pointing left toward the button
struct ChatboxPointer: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
