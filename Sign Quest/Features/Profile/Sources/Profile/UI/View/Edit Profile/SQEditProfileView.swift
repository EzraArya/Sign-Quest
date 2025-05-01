//
//  SQEditProfileView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQEditProfileView: View {
    @EnvironmentObject var coordinator: SQProfileCoordinator
    @StateObject var viewModel: SQEditProfileViewModel = SQEditProfileViewModel()
            
    public init() {}
    
    public var body: some View {
        VStack(spacing: 20) {
            SQLabelTextField(label: "First Name", title: "firstName", text: $viewModel.firstName, placeholder: "Enter your first name")
            SQLabelTextField(label: "Last Name", title: "lastName", text: $viewModel.lastName, placeholder: "Enter your last name")
            SQLabelTextField(label: "Email", title: "Email", text: $viewModel.email, placeholder: "Enter your Email")
            
            SQButton(text: "Change Password", font: .bold, style: .muted, size: 16) {
                viewModel.navigateToChangePassword()
            }
            
            Spacer()
            
            SQButton(text: "Save", font: .bold, style: .default, size: 16) {
                viewModel.updateProfile()
            }
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
                SQText(text: "Profile", font: .bold, color: .secondary, size: 24)
            }
        }
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}
