//
//  SQHomeViewModel.swift
//  Home
//
//  Created by Ezra Arya Wijaya on 01/05/25.
//

import SwiftUI
import Combine
import SignQuestModels
import SignQuestUI

class SQHomeViewModel: ObservableObject {
    @Published public var user: SQUser = SQUser(
        firstName: "User",
        lastName: "",
        email: "",
        age: 0,
        password: ""
    )
    
    @Published public var sections: [SQSection] = []
    @Published public var currentSection: SQSection?
    @Published var activePopup: (sectionId: String, levelId: String)? = nil

    private var coordinator: SQHomeCoordinator?
    private var networkService = SQHomeNetworkService()
    
    init() {}
    
    func setCoordinator(_ coordinator: SQHomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func setActivePopup(_ level: String?) {
        if let level = level {
            activePopup = (currentSection?.id ?? "", level)
        } else {
            activePopup = nil
        }
    }

    func isActivePopup(for sectionId: String, levelId: String) -> Bool {
        return activePopup?.sectionId == sectionId && activePopup?.levelId == levelId
    }
    
    @MainActor
    func loadUserData() async {
        self.user = await networkService.fetchUserData()
    }
    
    @MainActor
    func loadSections() async {
        self.sections = await networkService.fetchSection()
        self.currentSection = sections.first
    }
    
    @MainActor
    func navigateToGame(for level: SQLevel) {
        if level.status == .available || level.status == .completed {
            coordinator?.navigateToGame()
        }
    }
    
    func getLevelButtonStyle(for level: SQLevel) -> SQLevelButtonStyle {
        switch level.status {
        case .locked:
            return .locked
        case .available:
            return .default
        case .completed:
            return .completed
        }
    }
    
    func canNavigate(to level: SQLevel) -> Bool {
        return level.status == .available
    }
}
