//
//  SQEditProfilePictureViewModel.swift
//  Profile
//
//  Created by Ezra Arya Wijaya on 08/06/25.
//

import SwiftUI
import SignQuestCore

@MainActor
class SQEditProfilePictureViewModel: ObservableObject {
    @Published var profilePicture: UIImage? = nil
    
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
    
    func updateProfilePicture(_ image: UIImage) async {
        guard let userId = userManager?.firestoreUser?.id, let profilePicture = profilePicture else {
            return
        }
        
        Task {
            try await networkService.uploadProfilePicture(userId: userId, image: profilePicture)
        }
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
