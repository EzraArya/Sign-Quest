//
//  SQPlayCoordinator.swift
//  Play
//
//  Created by Ezra Arya Wijaya on 26/04/25.
//

import SwiftUI
import SignQuestInterfaces

public enum SQPlayScreenType: Hashable, Identifiable {
    case loading
    case games
    case finish
    case score
    
    public var id: Self { return self }
}

public enum SQPlaySheetType: Hashable, Identifiable {
    case setting
    
    public var id: Self { return self }
}

public class SQPlayCoordinator: NavigationCoordinatorProtocol, SheetCoordinatorProtocol {
    public typealias Sheet = SQPlaySheetType
    public typealias ScreenType = SQPlayScreenType
    @Published public var sheet: SQPlaySheetType?
    @Published public var path: NavigationPath = NavigationPath()
    private weak var appCoordinator: (any AppCoordinatorProtocol)?
    
    public init(appCoordinator: (any AppCoordinatorProtocol)? = nil) {
        self.appCoordinator = appCoordinator
    }
    
    
    public func presentSheet(_ sheet: SQPlaySheetType) {
        self.sheet = sheet
    }

    public func dismissSheet() {
        self.sheet = nil
    }
    
    
    public func push(_ screen: ScreenType) {
        path.append(screen)
    }
    
    public func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    public func popToRoot() {
        path = NavigationPath()
    }
    
    @MainActor
    public func navigateToHome() {
        appCoordinator?.startMainFlow()
    }
    
    @MainActor
    @ViewBuilder
    public func build(_ screen: ScreenType) -> some View {
        switch screen {
        case .loading:
            SQLoadingView()
        case .games:
            SQGamesView()
        case .finish:
            SQFinishView()
        case .score:
            SQScoreView()
        }
    }
    
    @MainActor
    @ViewBuilder
    public func build(_ sheet: Sheet) -> some View {
        switch sheet {
        case .setting:
            SQSettingView()
        }
    }
}
