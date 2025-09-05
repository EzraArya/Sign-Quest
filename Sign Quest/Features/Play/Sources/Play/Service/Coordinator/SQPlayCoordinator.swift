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
    case camera(Binding<UIImage?>)
    
    public var id: Self {
        switch self {
        case .setting: 
            return .setting
        case .camera(let binding): 
            return .camera(binding)
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .setting:
            hasher.combine(0)
        case .camera:
            hasher.combine(1)
        }
    }
    
    public static func == (lhs: SQPlaySheetType, rhs: SQPlaySheetType) -> Bool {
        switch (lhs, rhs) {
        case (.setting, .setting):
            return true
        case (.camera, .camera):
            return true
        default:
            return false
        }
    }
}

public class SQPlayCoordinator: NavigationCoordinatorProtocol, SheetCoordinatorProtocol {
    public typealias Sheet = SQPlaySheetType
    public typealias ScreenType = SQPlayScreenType
    @Published public var sheet: SQPlaySheetType?
    @Published public var path: NavigationPath = NavigationPath()
    private weak var appCoordinator: (any AppCoordinatorProtocol)?
    private let levelId: String
    
    public init(appCoordinator: (any AppCoordinatorProtocol)? = nil, levelId: String) {
        self.appCoordinator = appCoordinator
        self.levelId = levelId
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
        case .camera(let imageBinding):
            SQCameraView(image: imageBinding)
        }
    }
}
