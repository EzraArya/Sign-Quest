//
//  SQFinishView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//


import SwiftUI
import SignQuestUI

public struct SQFinishView: View {
    @EnvironmentObject var coordinator: SQPlayCoordinator
    @StateObject private var sharedViewModel = SQPlayViewModel.shared

    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            SQText(text: "😆", font: .bold, color: .text, size: 76)
            SQText(
                text: sharedViewModel.isLevelCompleted ? "Level Complete!" : "Level Attempted!",
                font: .bold,
                color: .text,
                size: 24
            )
        }
        .applyBackground()
        .task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            coordinator.push(.score)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
