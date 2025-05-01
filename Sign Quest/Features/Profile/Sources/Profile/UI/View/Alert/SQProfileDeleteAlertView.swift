//
//  SQProfileDeleteAlertView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

struct SQProfileDeleteAlertView: View {
    @Binding var isPresented: Bool
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }

            SQAlert(
                title: "Delete Account",
                message: "Are you sure you want to delete your account? This action cannot be undone.",
                primaryButtonTitle: "Delete",
                secondaryButtonTitle: "Cancel",
                primaryButtonAction: {
                    withAnimation(.easeOut(duration: 0.2)) {
                        onDelete()
                        isPresented = false
                    }
                },
                secondaryButtonAction: {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isPresented = false
                    }
                }
            )
            .padding(.horizontal, 24)
            .transition(
                .asymmetric(
                    insertion: .scale(scale: 0.8).combined(with: .opacity),
                    removal: .scale(scale: 0.9).combined(with: .opacity)
                )
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPresented)
            .zIndex(1)
        }
        .animation(.easeInOut, value: isPresented)
    }
}

