//
//  SQGreetViewModel.swift
//  Authentication
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI

class SQGreetViewModel: ObservableObject {
    private var coordinator: SQAuthenticationCoordinator?
    
    func setCoordinator(_ coordinator: SQAuthenticationCoordinator) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func navigateToHome() {
        coordinator?.showMainFlow()
    }
}
