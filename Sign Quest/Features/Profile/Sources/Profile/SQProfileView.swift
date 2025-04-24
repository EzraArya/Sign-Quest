//
//  SQProfileView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI

public struct SQProfileView: View {
    let coordinator: SQProfileCoordinator
    
    @State private var email: String = "email@gmail.com"
    @State private var joinDate: String = "9th December"
    
    @State private var showDeleteAlert: Bool = false

    public init(coordinator: SQProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        ZStack {
            SQColor.muted.color
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .center, spacing: 0) {
                    if let uiImage = UIImage(named: "ayame", in: .module, compatibleWith: nil) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    } else {
                        SQImage(image: "person", width: 100, height: 100)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    }
                }
                .background(SQColor.muted.color)

                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 6) {
                            SQText(text: "John Doe", font: .bold, color: .text, size: 24)
                            SQText(text: "\(email) ◦ \(joinDate)", font: .regular, color: .placeholder, size: 14)
                        }
                        SQButton(text: "Edit Profile", font: .bold, style: .default, size: 16) {
                            coordinator.showEditProfileView()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        SQText(text: "Overview", font: .medium, color: .text, size: 18)
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                SQImageTextBox(image: "star", imageColor: .complementary,title: "50.000", description: "Total Score")
                                SQImageTextBox(image: "hand.raised",imageColor: .cream, title: "10", description: "Sign Learned")
                            }
                            HStack(spacing: 16) {
                                SQImageTextBox(image: "flame",imageColor: .red, title: "5", description: "Day Streak")
                                SQImageTextBox(image: "medal",imageColor: .complementary, title: "2", description: "Finished Level")
                            }
                        }
                    }
                    
                    VStack(spacing: 16) {
                        SQButton(text: "Logout", font: .bold, style: .secondary, size: 16) {
                            coordinator.logOut()
                        }
                        SQButton(text: "Delete Account", font: .bold, style: .danger, size: 16) {
                            showDeleteAlert.toggle()
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .applyBackground()
            
            if showDeleteAlert {
                SQProfileDeleteAlertView(
                    isPresented: $showDeleteAlert,
                    onDelete: {
                        coordinator.deleteAccount()
                    }
                )
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}
