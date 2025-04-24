//
//  Sign_QuestApp.swift
//  Sign Quest
//

import SwiftUI
import SignQuestUI

@main
struct Sign_QuestApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            CoordinatorHostingView(coordinator: appState.coordinator)
                .onAppear {
                    Task { @MainActor in
                        appState.coordinator.start()
                    }
                }
                .ignoresSafeArea()
                .applyBackground()
        }
    }
}

@MainActor
class AppState: ObservableObject {
    let coordinator = AppCoordinator.create()
}


struct CoordinatorHostingView: UIViewControllerRepresentable {
    let coordinator: AppCoordinator
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return coordinator.navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
