//
//  SQCoordinatorProtocol.swift
//  SignQuestInterfaces
//
//  Created by Ezra Arya Wijaya on 25/04/25.
//

import SwiftUI

public protocol NavigationCoordinatorProtocol: ObservableObject {
    associatedtype ScreenType: Hashable & Identifiable
    var path: NavigationPath { get set }

    func push(_ screen: ScreenType)
    func pop()
    func popToRoot()
}

public protocol SheetCoordinatorProtocol: ObservableObject {
    associatedtype Sheet: Hashable & Identifiable
    var sheet: Sheet? { get set }
    func presentSheet(_ sheet: Sheet)
    func dismissSheet()
}

public protocol FullScreenCoverCoordinatorProtocol: ObservableObject {
    associatedtype FullScreenCover: Hashable & Identifiable
    var fullScreenCover: FullScreenCover? { get set }
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover)
    func dismissFullScreenCover()
}

@MainActor
public protocol TabBarCoordinatorProtocol: ObservableObject {
    associatedtype TabType: Hashable
    var activeTab: TabType { get set }
    
    func switchTab(to tab: TabType)
}

@MainActor
public protocol AppCoordinatorProtocol: ObservableObject {
    func startOnboarding()
    func startMainFlow()
    func startAuthentication(isLogin: Bool)
    func startGame()
}
