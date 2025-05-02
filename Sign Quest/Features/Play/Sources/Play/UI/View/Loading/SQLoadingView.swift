//
//  SQLoadingView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQLoadingView: View {
    @EnvironmentObject var coordinator: SQPlayCoordinator
    @StateObject private var sharedViewModel = SQPlayViewModel.shared

    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            SQText(text: "😀", font: .bold, color: .text, size: 76)
            SQText(text: "Loading Game!", font: .bold, color: .text, size: 24)
        }
        .applyBackground()
        .task {
            // Reset shared view model when starting a new game
            sharedViewModel.reset()
            
            try? await Task.sleep(nanoseconds: 800_000_000)
            coordinator.push(.games)
        }
    }
}
