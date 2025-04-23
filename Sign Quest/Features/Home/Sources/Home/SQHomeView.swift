//
//  SQHomeView.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQHomeView: View {
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
                
                LevelChatBubbleView()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(. horizontal, 24)
        .padding(.top, 16)
        .applyBackground()
    }
}

struct LevelChatBubbleView: View {
    @State private var showChat = false

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                if showChat {
                    ChatBubble {
                        VStack(spacing: 10) {
                            Text("Ready to start Level 1?")
                                .font(.subheadline)
                                .padding(.bottom, 5)

                            HStack {
                                Button("Start") {
                                    print("Start tapped")
                                    showChat = false
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)

                                Button("Cancel") {
                                    showChat = false
                                }
                                .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                    .transition(.scale)
                    .animation(.easeInOut, value: showChat)
                }

                Button(action: {
                    withAnimation {
                        showChat.toggle()
                    }
                }) {
                    VStack {
                        Text("1")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        Text("Level")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .frame(width: 80, height: 80)
                    .background(Color.green)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                }
            }
        }
    }
}

// MARK: - Chat Bubble Shape

struct ChatBubble<Content: View>: View {
    var content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            content()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    Triangle()
                        .fill(Color.white)
                        .frame(width: 20, height: 10)
                        .rotationEffect(.degrees(180))
                        .offset(y: 5),
                    alignment: .bottom
                )
                .shadow(radius: 5)
        }
    }
}

// MARK: - Triangle Shape for Bubble Tail

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))   // bottom center
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY)) // left
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // right
            path.closeSubpath()
        }
    }
}

