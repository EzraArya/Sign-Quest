//
//  SQWelcomeView.swift
//  Onboarding
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI
import Combine

public struct SQWelcomeView: View {
    @StateObject var viewModel = SQWelcomeViewModel()
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            VStack(spacing: 24) {
                SQText(text: viewModel.title, font: .bold, color: .secondary, size: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                SQButton(text: viewModel.buttonTitle, font: .bold, style: .default, size: 16) {
                    print("Hello")
                }
            }
            
            SQSeperator(color: .line)
                    
            VStack(spacing: 24) {
                SQText(text: viewModel.subtitle, font: .bold, color: .secondary, size: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                SQButton(text: viewModel.buttonSubtitle, font: .bold, style: .secondary, size: 16) {
                    print("Hello")
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}
