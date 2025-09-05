# Copilot Instructions for Sign Quest

## Project Overview
**Sign Quest** is an interactive iOS sign language learning game built with SwiftUI, Firebase, and Core ML for AI-powered gesture recognition.

- **Technology**: Swift 6.1, SwiftUI, Firebase (Auth/Firestore), Core ML
- **Target**: iOS 16+
- **Architecture**: Modular Swift Package Manager with feature-based modules

## Core Architecture

### Project Structure
```
Sign Quest/
├── App/                    # Main app entry point
├── Core/Packages/          # Shared functionality
│   ├── SignQuestCore/      # Business logic, managers
│   ├── SignQuestModels/    # Data models
│   ├── SignQuestInterfaces/# Protocols
│   └── SignQuestUI/        # Shared UI components
└── Features/               # Feature modules (SPM packages)
    ├── Authentication/
    ├── Dashboard/
    ├── Home/
    ├── Play/              # Game/learning with ML
    └── Profile/
```

### Key Patterns
- **Coordinator Pattern**: Navigation managed by coordinators (e.g., `SQHomeCoordinator`)
- **Manager Pattern**: Singletons for core functionality (`UserManager`, `LevelManager`)
- **MVVM**: ViewModels + Coordinators for navigation
- **Protocol-Oriented**: Heavy use of protocols for dependency injection

## Essential Coding Standards

### Naming Conventions
- **Prefix**: All custom types use `SQ` prefix (e.g., `SQUser`, `SQLevel`)
- **Access Control**: `public` for cross-module, `private` for internal
- **Concurrency**: `async/await` for network operations, `@unchecked Sendable` for managers

### Property Wrappers
```swift
@DocumentID var id: String?           // Firebase document IDs
@ServerTimestamp var timestamp: Date? // Firebase timestamps
@Published var state: AppState        // Observable properties
@StateObject var coordinator          // View ownership
```

### File Structure
```swift
//
// File: /Path/To/File.swift
// Created: YYYY-MM-DD
//

import Foundation
import SwiftUI
import Firebase

// MARK: - Protocol
protocol SomeProtocol { }

// MARK: - Implementation
class SomeClass: SomeProtocol { }

// MARK: - Extensions
extension SomeClass { }
```

## Development Workflow

### Swift Package Manager
- Each feature is a separate package with `Package.swift`
- Minimum deployment: iOS 16
- Core packages are dependencies for feature packages

### Firebase Integration
- Models conform to `Codable` with Firebase property wrappers
- All models: `Hashable`, `Identifiable`, `@unchecked Sendable`
- Network operations through dedicated service protocols

### State Management
- `AppCoordinator` manages overall app state with `AppState` enum
- Feature coordinators handle local navigation
- `UserManager` singleton for user state

## Key File Locations

### Core Managers
- **User Management**: `/Core/Packages/SignQuestCore/Sources/SignQuestCore/Managers/UserManager.swift`
- **Level Management**: `/Core/Packages/SignQuestCore/Sources/SignQuestCore/Managers/LevelManager.swift`
- **App Coordination**: `/App/AppCoordinator.swift`

### Data Models
- **Models Directory**: `/Core/Packages/SignQuestModels/Sources/SignQuestModels/`
- **Key Models**: `SQUser`, `SQLevel`, `SQQuestion`, `SQGameSession`

## Critical Guidelines

### Always Do:
- Use `SQ` prefix for all custom types
- Include proper error handling for async operations
- Mark classes as `@unchecked Sendable` for concurrency
- Use coordinator pattern for navigation
- Access Firebase through managers/services, never directly from Views
- Consider accessibility (VoiceOver, Dynamic Type, contrast)
- Include file headers with creation date

### Never Do:
- Bypass coordinator pattern for navigation
- Use forced unwrapping without error handling
- Access Firebase directly from Views
- Create singletons without thread safety
- Ignore dark mode support (app uses `.preferredColorScheme(.dark)`)

## Firebase Data Patterns

### Model Example
```swift
struct SQUser: Codable, Identifiable, Hashable, @unchecked Sendable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Date?
    let username: String
    let email: String
}
```

### Service Pattern
```swift
protocol UserServiceProtocol {
    func createUser(_ user: SQUser) async throws -> SQUser
    func fetchUser(id: String) async throws -> SQUser?
}
```

## ML Integration

### Core ML Pattern
- Load models asynchronously on background queues
- Use `VNImageRequestHandler` for vision processing
- Handle camera permissions and availability
- Provide visual feedback during processing

### Performance Considerations
- Cache model instances appropriately
- Monitor inference times and memory usage
- Use lazy loading for heavy resources
- Implement proper camera session lifecycle

## Accessibility Requirements

**Critical**: This is a sign language learning app - accessibility is paramount.

- Always provide `accessibilityLabel`, `accessibilityHint`, `accessibilityValue`
- Support VoiceOver navigation
- Ensure 44x44pt minimum touch targets
- Maintain WCAG AA contrast ratios (4.5:1)
- Support Dynamic Type and Reduce Motion
- Test with VoiceOver enabled

## Testing Approach

### Package Testing
- Each package includes test targets
- Test managers with mock services
- Test Firebase integration with test projects
- Test coordinator navigation logic

### UI Testing
- Test critical user journeys (onboarding → auth → play)
- Test accessibility compliance
- Test gesture recognition flows

## Quick Start for New Features

1. Create new Swift Package in `Features/` directory
2. Add `Package.swift` with proper dependencies
3. Implement coordinator following `NavigationCoordinatorProtocol`
4. Create network service with protocol
5. Build UI components with accessibility support
6. Add to main app navigation flow

## Error Handling Pattern

```swift
enum NetworkError: LocalizedError {
    case noConnection
    case invalidResponse
    case firebaseError(Error)
    
    var errorDescription: String? {
        // Provide user-friendly messages
    }
}
```

---

*For comprehensive details, see `copilot-instruction-enhanced.md`*