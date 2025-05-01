//
//  SQSettingView.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQSettingView: View {
    @EnvironmentObject var coordinator: SQPlayCoordinator

    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            SQText(text: "Settings", font: .bold, color: .text, size: 24)
                .padding(.vertical, 8)
            Spacer()
            SQButton(text: "Done", font: .bold, style: .muted, size: 16) {
                coordinator.dismissSheet()
            }
            SQButton(text: "END SESSION", font: .bold, style: .danger, size: 16) {
                coordinator.navigateToHome()
            }
            
            Spacer()
        }
        .padding(24)
    }
}
