//
//  SQGreetView.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQGreetView: View {
    @EnvironmentObject var coordinator: SQAuthenticationCoordinator

    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            SQText(text: "🥹", font: .bold, color: .text, size: 76)
            SQText(text: "Welcome User!", font: .bold, color: .text, size: 24)
        }
        .applyBackground()
        .task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            coordinator.showMainFlow()
        }
    }
}
