//
//  SQEditProfilePictureView.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 08/06/25.
//

import SwiftUI
import PhotosUI
import SignQuestUI
import SignQuestCore

public struct SQEditProfilePictureView: View {
    @EnvironmentObject var coordinator: SQProfileCoordinator
    @EnvironmentObject var userManager: UserManager
    @StateObject var viewModel = SQEditProfilePictureViewModel()
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Group {
                    if let selectedImage = viewModel.profilePicture {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                    } else if let currentProfilePicture = viewModel.userProfilePicture {
                        AsyncImage(url: URL(string: currentProfilePicture)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.gray)
                                )
                        }
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "person.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 40))
                            )
                    }
                }
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                )
                
                Text("Profile Picture")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            VStack(spacing: 16) {
                PhotosPicker("Select New Photo",
                             selection: $viewModel.selectedImage,
                             matching: .images)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                if viewModel.profilePicture != nil {
                    Button("Update Profile Picture") {
                        Task {
                            await viewModel.updateProfilePicture()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(viewModel.isUploading)
                }
                
                if viewModel.profilePicture != nil {
                    Button("Cancel") {
                        viewModel.clearSelection()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
            }
            
            VStack(spacing: 8) {
                if viewModel.isUploading {
                    HStack {
                        ProgressView()
                            .scaleEffect(0.8)
                        Text("Uploading...")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                if viewModel.uploadSuccess {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Profile picture updated successfully!")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                }
                
                if let error = viewModel.uploadError {
                    HStack {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundColor(.red)
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .padding()
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
                SQText(text: "Change Profile Picture", font: .bold, color: .secondary, size: 24)
            }
        }
        .onChange(of: viewModel.selectedImage) { _ in
            Task {
                await viewModel.handlePhotoSelection()
            }
        }
        .onAppear {
            viewModel.link(userManager: userManager, coordinator: coordinator)
        }
    }
}
