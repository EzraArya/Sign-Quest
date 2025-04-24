//
//  SQEditProfileView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQEditProfileView: View {
    let coordinator: SQProfileCoordinator
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
            
    public init(coordinator: SQProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            SQLabelTextField(label: "First Name", title: "firstName", text: $firstName, placeholder: "Enter your first name")
            SQLabelTextField(label: "Last Name", title: "lastName", text: $lastName, placeholder: "Enter your last name")
            SQLabelTextField(label: "Email", title: "Email", text: $email, placeholder: "Enter your Email")
            
            SQButton(text: "Change Password", font: .bold, style: .muted, size: 16) {
                coordinator.showEditPasswordView()
            }
            
            Spacer()
            
            SQButton(text: "Save", font: .bold, style: .default, size: 16) {
                coordinator.navigateBack()
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 24)
        .applyBackground()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    coordinator.navigateBack()
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
    }
}
