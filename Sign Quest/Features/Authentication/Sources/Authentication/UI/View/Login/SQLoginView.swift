//
//  SQLoginView.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 22/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQLoginView: View {
    @EnvironmentObject var coordinator: SQAuthenticationCoordinator

    @StateObject private var viewModel = SQLoginViewModel()
    @FocusState private var isEmailActive: Bool
    @FocusState private var isPasswordActive: Bool
    @Environment(\.dismiss) private var dismiss

    public init() {}
    
    public var body: some View {
        VStack {
            VStack(spacing: 16) {
                SQTextField(
                    title: "Email",
                    text: $viewModel.email,
                    placeholderText: "Enter your email",
                    style: viewModel.emailStyle
                )
                .focused($isEmailActive)
                .onChange(of: isEmailActive) { isActive in
                    viewModel.validateInput(isEmailActive: isActive, isPasswordActive: isPasswordActive)
                }

                SQTextField(
                    title: "Password",
                    text: $viewModel.password,
                    placeholderText: "Enter your password",
                    style: viewModel.passwordStyle,
                    isSecure: true
                )
                .focused($isPasswordActive)
                .onChange(of: isPasswordActive) { isActive in
                    viewModel.validateInput(isEmailActive: isEmailActive, isPasswordActive: isActive)
                }
            }
            Spacer()
            SQButton(text: "Sign In", font: .bold, style: .default, size: 16) {
                viewModel.validateInput(isEmailActive: isEmailActive, isPasswordActive: isPasswordActive)
                if !viewModel.hasError {
                    viewModel.login()
                }
            }
            .padding(.bottom, 16)

        }
        .padding(.top, 16)
        .padding(.horizontal, 24)
        .applyBackground()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.navigateBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(SQColor.secondary.color)
                }
            }
            ToolbarItem(placement: .principal) {
                SQText(text: "Enter your details", font: .bold, color: .secondary, size: 20)
            }
        }
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}
