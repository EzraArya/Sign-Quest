//
//  SQEditProfilePictureViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 08/06/25.
//

import SwiftUI
import SignQuestCore
import PhotosUI

@MainActor
class SQEditProfilePictureViewModel: ObservableObject {
    @Published var profilePicture: UIImage? = nil
    @Published var selectedImage: PhotosPickerItem? = nil
    @Published var isUploading = false
    @Published var uploadError: String?
    @Published var uploadSuccess = false
    
    private var userManager: UserManager?
    private var coordinator: SQProfileCoordinator?
    private let networkService: SQProfileNetworkServiceProtocol
    
    init(networkService: SQProfileNetworkServiceProtocol = SQProfileNetworkService()) {
        self.networkService = networkService
    }
    
    func link(userManager: UserManager, coordinator: SQProfileCoordinator) {
        self.userManager = userManager
        self.coordinator = coordinator
    }
    
    func handlePhotoSelection() async {
        guard let selectedImage = selectedImage else { return }
        
        do {
            if let data = try await selectedImage.loadTransferable(type: Data.self) {
                let uiImage = UIImage(data: data)
                self.profilePicture = uiImage
                uploadError = nil
            }
        } catch {
            uploadError = "Failed to load image: \(error.localizedDescription)"
        }
    }
    
    func updateProfilePicture() async {
        guard let userId = userManager?.firestoreUser?.id,
              let profilePicture = profilePicture else {
            uploadError = "Missing user ID or profile picture"
            return
        }
        
        isUploading = true
        uploadError = nil
        uploadSuccess = false
        
        do {
            try await networkService.uploadProfilePicture(userId: userId, image: profilePicture)
            uploadSuccess = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.navigateBack()
            }
        } catch {
            uploadError = "Upload failed: \(error.localizedDescription)"
        }
        
        isUploading = false
    }
    
    func clearSelection() {
        selectedImage = nil
        profilePicture = nil
        uploadError = nil
        uploadSuccess = false
    }
    
    func navigateBack() {
        coordinator?.pop()
    }
}

extension SQEditProfilePictureViewModel {
    var userProfilePicture: String? {
        return userManager?.firestoreUser?.image
    }
}
