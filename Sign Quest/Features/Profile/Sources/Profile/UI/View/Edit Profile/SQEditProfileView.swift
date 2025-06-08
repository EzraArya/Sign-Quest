//
//  SQEditProfileView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI
import SignQuestCore

public struct SQEditProfileView: View {
    @EnvironmentObject var coordinator: SQProfileCoordinator
    @EnvironmentObject var userManager: UserManager
    
    @StateObject private var viewModel = SQEditProfileViewModel()
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 20) {
            SQLabelTextField(label: "First Name", title: "firstName", text: $viewModel.firstName, placeholder: "Enter your first name")
                .disabled(viewModel.isLoading)
            
            SQLabelTextField(label: "Last Name", title: "lastName", text: $viewModel.lastName, placeholder: "Enter your last name")
                .disabled(viewModel.isLoading)
            
            SQLabelTextField(label: "Email", title: "Email", text: $viewModel.email, placeholder: "Enter your Email")
                .disabled(true)
            
            SQButton(text: "Change Password", font: .bold, style: .muted, size: 16) {
                viewModel.navigateToChangePassword()
            }
            
            Spacer()
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.bottom, 8)
            }
            
            SQButton(
                text: viewModel.isLoading ? "Saving..." : "Save",
                font: .bold,
                style: .default,
                size: 16
            ) {
                Task {
                    await viewModel.updateProfile()
                }
            }
            .disabled(viewModel.isLoading)
        }
        .padding(.top, 24)
        .padding(.horizontal, 24)
        .applyBackground()
        .toolbar(.hidden, for: .tabBar)
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
                SQText(text: "Edit Profile", font: .bold, color: .secondary, size: 24)
            }
        }
        .onAppear {
            viewModel.link(userManager: userManager, coordinator: coordinator)
        }
    }
}
