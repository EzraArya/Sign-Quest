//
//  SQGreetView.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI
import Dashboard

public struct SQGreetView: View {
    @State private var navigateToDashboard: Bool = false

    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            SQText(text: "🥹", font: .bold, color: .text, size: 76)
            SQText(text: "Welcome User!", font: .bold, color: .text, size: 24)
        }
        .applyBackground()
        .task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            navigateToDashboard = true
        }
        .navigationDestination(isPresented: $navigateToDashboard) {
            SQDashboardView()
        }
    }
}
