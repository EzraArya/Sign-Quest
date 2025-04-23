//
//  SQChangePasswordView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQChangePasswordView: View {
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            SQLabelTextField(label: "Old Password", title: "oldPassword", text: $oldPassword, placeholder: "", isPassword: true)
            SQLabelTextField(label: "New Password", title: "newPassword", text: $newPassword, placeholder: "", isPassword: true)
            SQLabelTextField(label: "Confirm Password", title: "confirmPassword", text: $confirmPassword, placeholder: "", isPassword: true)

            Spacer()
            
            SQButton(text: "Save", font: .bold, style: .default, size: 16) {
                dismiss()
            }
        }
        .padding(.top, 24)
        .padding(.horizontal, 24)
        .applyBackground()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
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
    }
}
