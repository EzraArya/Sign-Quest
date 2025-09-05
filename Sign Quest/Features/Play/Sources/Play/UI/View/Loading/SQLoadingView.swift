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
import Combine

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
        .onReceive(viewModel.$isLoading) { isLoading in
            if !isLoading && viewModel.currentQuestion != nil {
                coordinator.push(.games)
            }
        }
    }
}
