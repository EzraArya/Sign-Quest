//
//  SQChangePasswordView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQChangePasswordView: View {
    @EnvironmentObject var coordinator: SQProfileCoordinator
    @StateObject var viewModel: SQChangePasswordViewModel = SQChangePasswordViewModel()
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            SQLabelTextField(label: "Old Password", title: "oldPassword", text: $viewModel.oldPassword, placeholder: "", isPassword: true)
            SQLabelTextField(label: "New Password", title: "newPassword", text: $viewModel.newPassword, placeholder: "", isPassword: true)
            SQLabelTextField(label: "Confirm Password", title: "confirmPassword", text: $viewModel.confirmPassword, placeholder: "", isPassword: true)

            Spacer()
            
            SQText(text: viewModel.errorMessage, font: .medium, color: .error, size: 12)
                .padding(.bottom, 12)
            SQButton(text: "Save", font: .bold, style: .default, size: 16) {
                viewModel.changePassword()
            }
        }
        .applyBackground()
        .padding(.top, 24)
        .padding(.horizontal, 24)
        .applyBackground()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.navigateBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundColor(SQColor.secondary.color)
                }
            }
            ToolbarItem(placement: .principal) {
                SQText(text: "Change Password", font: .bold, color: .secondary, size: 24)
            }
        }
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}
