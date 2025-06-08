//
//  SQProfileView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI
import SignQuestUI
import SignQuestCore

public struct SQProfileView: View {
    @EnvironmentObject var coordinator: SQProfileCoordinator
    @EnvironmentObject var userManager: UserManager
    
    @StateObject private var viewModel = SQProfileViewModel()

    public init() {}
    
    public var body: some View {
        ZStack {
            SQColor.muted.color
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .center, spacing: 0) {
                    if let imageUrlString = viewModel.profilePicture, let url = URL(string: imageUrlString) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            case .failure:
                                SQImage(image: "person", width: 100, height: 100)
                                    .frame(height: 200)
                                    .frame(maxWidth: .infinity)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(uiImage: UIImage(named: "ayame", in: .module, compatibleWith: nil)!)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    }
                }
                .background(SQColor.muted.color)
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 6) {
                            SQText(text: viewModel.userName, font: .bold, color: .text, size: 24)
                            SQText(text: "\(viewModel.userEmail) ◦ \(viewModel.joinDate)", font: .regular, color: .placeholder, size: 14)
                        }
                        SQButton(text: "Edit Profile", font: .bold, style: .default, size: 16) {
                            viewModel.navigateToEditProfile()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        SQText(text: "Overview", font: .medium, color: .text, size: 18)
                        
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ],
                            spacing: 16
                        ) {
                            ForEach(viewModel.overviewItems, id: \.type) { item in
                                SQImageTextBox(
                                    image: item.type.image,
                                    imageColor: item.type.imageColor,
                                    title: item.value,
                                    description: item.type.description
                                )
                            }
                        }
                    }
                    
                    VStack(spacing: 16) {
                        SQButton(text: "Logout", font: .bold, style: .secondary, size: 16) {
                            viewModel.logout()
                        }
                        SQButton(text: "Delete Account", font: .bold, style: .danger, size: 16) {
                            viewModel.showDeleteAlert.toggle()
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .redacted(reason: viewModel.isLoading ? .placeholder : [])
            .animation(.easeInOut, value: viewModel.isLoading)
            .applyBackground()
            
            if viewModel.showDeleteAlert {
                SQProfileDeleteAlertView(
                    isPresented: $viewModel.showDeleteAlert,
                    onDelete: {
                        viewModel.deleteAccount()
                    }
                )
            }
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            viewModel.link(userManager: userManager, coordinator: coordinator)
        }
    }
}
