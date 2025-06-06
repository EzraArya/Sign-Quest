//
//  Sign_QuestApp.swift
//  Sign Quest
//

import SwiftUI
import Firebase
import SignQuestCore

@main
struct Sign_QuestApp: App {
    
    @StateObject private var userManager: UserManager
    @StateObject private var appCoordinator: AppCoordinator

    init() {
        FirebaseApp.configure()

        let userManager = UserManager()
        let appCoordinator = AppCoordinator(userManager: userManager)

        _userManager = StateObject(wrappedValue: userManager)
        _appCoordinator = StateObject(wrappedValue: appCoordinator)
    }
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.makeRootView()
                .environmentObject(userManager)
                .environmentObject(appCoordinator)
        }
    }
}
