# SignQuestInterfaces Package

> Shared protocols for navigation coordinators.

## Dependencies

- SwiftUI only (no external dependencies)

---

## Protocols

### NavigationCoordinatorProtocol

Stack-based navigation:

```swift
public protocol NavigationCoordinatorProtocol: ObservableObject {
    associatedtype ScreenType: Hashable & Identifiable
    var path: NavigationPath { get set }

    func push(_ screen: ScreenType)
    func pop()
    func popToRoot()
}
```

**Used by:** All feature coordinators (Home, Play, Profile, etc.)

---

### SheetCoordinatorProtocol

Modal sheet presentation:

```swift
public protocol SheetCoordinatorProtocol: ObservableObject {
    associatedtype Sheet: Hashable & Identifiable
    var sheet: Sheet? { get set }
    
    func presentSheet(_ sheet: Sheet)
    func dismissSheet()
}
```

**Used by:** `SQPlayCoordinator` (settings, camera sheets)

---

### FullScreenCoverCoordinatorProtocol

Full-screen modal presentation:

```swift
public protocol FullScreenCoverCoordinatorProtocol: ObservableObject {
    associatedtype FullScreenCover: Hashable & Identifiable
    var fullScreenCover: FullScreenCover? { get set }
    
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover)
    func dismissFullScreenCover()
}
```

---

### TabBarCoordinatorProtocol

Tab-based navigation:

```swift
@MainActor
public protocol TabBarCoordinatorProtocol: ObservableObject {
    associatedtype TabType: Hashable
    var activeTab: TabType { get set }
    
    func switchTab(to tab: TabType)
}
```

**Used by:** `SQDashboardCoordinator`

---

### AppCoordinatorProtocol

App-level navigation state:

```swift
@MainActor
public protocol AppCoordinatorProtocol: ObservableObject {
    func startOnboarding()
    func startMainFlow()
    func startAuthentication(isLogin: Bool)
    func startGame(levelId: String)
}
```

**Used by:** `AppCoordinator` in main app target

---

## Usage Pattern

Feature coordinators conform to protocols and are passed to child views:

```swift
// Coordinator implementation
public class SQHomeCoordinator: NavigationCoordinatorProtocol {
    public typealias ScreenType = SQHomeScreenType
    @Published public var path: NavigationPath = NavigationPath()
    
    // ... implementation
}

// View usage
struct SQHomeCoordinatorView: View {
    @StateObject var coordinator: SQHomeCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            // ...
        }
        .environmentObject(coordinator)
    }
}
```

---

## Common Tasks

### Adding a New Coordinator Protocol

1. Define protocol in this package
2. Include `ObservableObject` conformance
3. Use `associatedtype` for type safety
4. Add `@MainActor` if UI-bound
