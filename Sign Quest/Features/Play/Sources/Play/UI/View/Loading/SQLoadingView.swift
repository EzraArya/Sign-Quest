//
//  SQLoadingView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI
import Firebase
import SignQuestCore

public struct SQLoadingView: View {
    @EnvironmentObject var coordinator: SQPlayCoordinator
    @EnvironmentObject private var viewModel: SQGamesViewModel

    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            SQText(text: "😀", font: .bold, color: .text, size: 76)
            SQText(text: "Loading Game!", font: .bold, color: .text, size: 24)
        }
        .applyBackground()
        .task {
            while viewModel.isLoading {
                try? await Task.sleep(nanoseconds: 400_000_000)
            }
            
            coordinator.push(.games)
        }
    }
}
