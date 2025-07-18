# Sign Quest - GitHub Copilot Development Guide

## Project Overview

Sign Quest is an iOS application built with SwiftUI that provides an interactive and gamified approach to learning sign language. The app combines machine learning for gesture recognition with engaging gameplay mechanics to create an educational experience for users learning sign language.

### Key Features
- **Interactive Sign Language Learning**: Gamified lessons and exercises
- **Gesture Recognition**: Real-time sign language gesture detection using YOLO ML model
- **Progress Tracking**: User level progression and achievement system
- **Leaderboard**: Social competition features
- **Camera Integration**: Live gesture capture and analysis

## Architecture & Design Patterns

### Clean Architecture
The project follows clean architecture principles with clear separation of concerns:
- **Features**: Independent feature modules (Authentication, Play, Profile, etc.)
- **Core**: Shared business logic and utilities
- **UI**: Reusable UI components and design system

### Key Patterns Used
- **Coordinator Pattern**: Navigation management through `AppCoordinator` and feature coordinators
- **MVVM**: Model-View-ViewModel pattern for UI logic
- **Repository Pattern**: Data access abstraction
- **Dependency Injection**: Through environment objects and initializer injection

### Modular Architecture
The project uses Swift Package Manager for modularization:
```
Core/Packages/
├── SignQuestCore/     # Core business logic and services
├── SignQuestModels/   # Data models and entities
├── SignQuestInterfaces/ # Protocols and interfaces
└── SignQuestUI/       # Reusable UI components
```

## Technology Stack

### Core Technologies
- **SwiftUI**: Primary UI framework
- **Combine**: Reactive programming for data flow
- **Firebase**: Backend services (Authentication, Firestore, Analytics)
- **Core ML**: Machine learning model integration
- **YOLO**: Object detection model for gesture recognition
- **AVFoundation**: Camera and media handling

### Development Tools
- **Xcode**: Primary IDE
- **Swift Package Manager**: Dependency management
- **iOS 17+**: Minimum deployment target

## File Structure & Organization

```
Sign Quest/
├── App/                    # Application entry point and configuration
│   ├── AppDelegate.swift
│   ├── Sign_QuestApp.swift
│   └── AppCoordinator.swift
├── Core/                   # Shared resources and packages
│   ├── Assets.xcassets     # Images and colors
│   ├── Fonts/              # Custom fonts
│   ├── Model/              # ML models (yolo.mlmodel)
│   └── Packages/           # Swift packages
└── Features/               # Feature modules
    ├── Authentication/     # User login/registration
    ├── Dashboard/          # Main dashboard
    ├── Home/              # Home screen
    ├── Leaderboard/       # Competition features
    ├── Onboarding/        # User onboarding flow
    ├── Play/              # Game mechanics and ML integration
    └── Profile/           # User profile management
```

## Data Models

### Core Entities
- **SQUser**: User profile and authentication data
- **SQQuestion**: Learning exercise questions with types:
  - `selectAlphabet`: Multiple choice alphabet selection
  - `selectGesture`: Gesture identification
  - `performGesture`: Real-time gesture performance
- **SQLevel**: Learning progression levels
- **SQGameSession**: Active game session data
- **SQProgress**: User learning progress tracking

### Question Types
```swift
public enum SQQuestionType: String, Codable {
    case selectAlphabet    // Choose correct alphabet
    case selectGesture     // Identify gesture from options
    case performGesture    // Perform gesture with camera
}
```

## Development Conventions

### Naming Conventions
- **Prefix**: All custom types use `SQ` prefix (SignQuest)
- **Files**: Use descriptive names with feature prefixes
- **Views**: End with `View` (e.g., `SQGamesView`)
- **ViewModels**: End with `ViewModel` (e.g., `SQPlayViewModel`)
- **Coordinators**: End with `Coordinator` (e.g., `SQPlayCoordinator`)

### Code Organization
- Each feature module has its own Package.swift
- UI components are separated into View, ViewModel, and Coordinator
- Network services are abstracted behind protocols
- Models are shared across features through SignQuestModels package

### SwiftUI Patterns
- Use `@StateObject` for owned observable objects
- Use `@EnvironmentObject` for dependency injection
- Coordinator pattern for navigation with enum-based screen types
- Sheet and navigation stack management through coordinators

## Machine Learning Integration

### YOLO Model Integration
- Model file: `yolo.mlmodel` in Play package resources
- Real-time gesture detection through camera feed
- Integration with `YOLO` package from Ultralytics
- Image preprocessing and prediction handling

### Camera Implementation
```swift
// Camera view for gesture capture
struct SQCameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    // Camera configuration and delegate handling
}
```

## Common Development Tasks

### Adding New Features
1. Create new Swift package in `Features/`
2. Define Package.swift with dependencies
3. Implement Coordinator for navigation
4. Create ViewModels for business logic
5. Build SwiftUI views
6. Add models to SignQuestModels if needed

### Adding New Question Types
1. Extend `SQQuestionType` enum in SignQuestModels
2. Update question content structure
3. Implement UI handling in Play feature
4. Add ML processing if needed

### Working with Navigation
- Use coordinator pattern: `SQPlayCoordinator`, `AppCoordinator`
- Screen types defined as enums: `SQPlayScreenType`
- Sheet presentation through coordinator methods

### Firebase Integration
- User management through `UserManager`
- Firestore for data persistence
- Authentication state management

## Testing Strategy

### Test Structure
- Unit tests in `Tests/` directory of each package
- UI tests in `Sign QuestUITests/`
- Model tests in `Sign QuestTests/`

### Testing Patterns
- Mock coordinators for navigation testing
- ViewModel testing with mock services
- Model validation testing

## Performance Considerations

### ML Model Optimization
- YOLO model optimized for mobile devices
- Camera feed processing optimization
- Memory management for image processing

### UI Performance
- SwiftUI view optimization
- Lazy loading for lists and grids
- Image caching strategies

## Security & Privacy

### Data Protection
- Firebase security rules
- User data encryption
- Camera permission handling
- Private model data in gitignore

### Secrets Management
- GoogleService-Info.plist in gitignore
- API keys in separate configuration
- Environment-specific configurations

## Development Workflow

### Build Process
1. Open `Sign Quest.xcworkspace`
2. Select target device/simulator
3. Build and run through Xcode

### Adding Dependencies
- Use Swift Package Manager
- Add to relevant Package.swift files
- Update target dependencies

### ML Model Updates
- Replace `yolo.mlmodel` in Play package resources
- Test gesture recognition accuracy
- Update preprocessing if needed

## Debugging Tips

### Common Issues
- **Camera not working**: Check permissions in Info.plist
- **ML model errors**: Verify model file inclusion in bundle
- **Navigation issues**: Check coordinator state management
- **Firebase errors**: Verify GoogleService-Info.plist configuration

### Debugging Tools
- Xcode debugger for Swift code
- Firebase console for backend issues
- Simulator for UI testing
- Device testing for camera/ML features

## Code Examples

### Creating a New View with Coordinator
```swift
struct SQNewFeatureView: View {
    @EnvironmentObject var coordinator: SQNewFeatureCoordinator
    @StateObject var viewModel = SQNewFeatureViewModel()
    
    var body: some View {
        // View implementation
    }
}
```

### Adding ML Processing
```swift
func processGesture(_ image: UIImage) {
    // Image preprocessing
    // YOLO model prediction
    // Result handling
}
```

### Firebase Data Operations
```swift
func saveUserProgress(_ progress: SQProgress) async throws {
    // Firestore save operation
}
```

## Service Layer & Network Architecture

### Manager Pattern
The app uses a centralized manager pattern for core services:
- **UserManager**: Authentication and user state management with Firebase Auth and Firestore
- **SecretManager**: Secure configuration and API key management
- **UserDefaultManager**: Local storage for user preferences

### Network Services
Each feature module has its own network service following the pattern:
```swift
struct SQ[Feature]NetworkService {
    func fetch[Entity](id: String) async -> [Entity]? {
        // Network implementation
    }
}
```

### Service Dependencies
- **CloudinaryService**: Image upload and management with async/await pattern
- **Firebase Services**: Auth, Firestore, Analytics integration
- **YOLO Service**: ML model inference for gesture recognition

## State Management Patterns

### Observable Object Hierarchy
```swift
// App-level state management
@MainActor
public class UserManager: ObservableObject {
    @Published public var authUser: FirebaseAuth.User?
    @Published public var firestoreUser: SQUser?
    @Published public var profileImageUrl: String?
}

// Feature-level ViewModels
@MainActor
class SQ[Feature]ViewModel: ObservableObject {
    @Published var state: ViewState = .loading
    // Feature-specific state
}
```

### State Flow Patterns
- Use `@StateObject` for ViewModel ownership in Views
- Use `@EnvironmentObject` for shared services (UserManager, Coordinators)
- Use `@Published` for reactive state updates
- Combine publishers for complex data flows

## Error Handling Architecture

### Custom Error Types
Each service defines specific error enums:
```swift
public enum UserManagerError: Error, LocalizedError {
    case notAuthenticated
    case updateFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "User is not authenticated"
        case .updateFailed(let error):
            return "Update failed: \(error.localizedDescription)"
        }
    }
}
```

### Error Handling Patterns
- All async operations use `throws` for error propagation
- ViewModels handle errors and update UI state accordingly
- User-facing error messages through `LocalizedError` protocol
- Network errors are centrally handled in service layer

## Data Persistence & Synchronization

### Firebase Integration
- **Authentication**: Firebase Auth with state listeners
- **Firestore**: Real-time document synchronization with snapshot listeners
- **Offline Support**: Firestore automatic offline caching

### Local Storage
- **UserDefaults**: Simple key-value storage through UserDefaultManager
- **Image Caching**: Cloudinary URLs with local caching strategy
- **ML Model**: Bundled yolo.mlmodel in app resources

### Data Synchronization Patterns
```swift
// Real-time Firestore listener pattern
firestoreListener = db.collection("users").document(uid)
    .addSnapshotListener { [weak self] document, error in
        // Handle real-time updates
    }
```

## Configuration & Environment Management

### Secret Management
- **SecretManager**: Centralized configuration for API keys and sensitive data
- **Environment Variables**: Different configurations for debug/release
- **Gitignore Protection**: GoogleService-Info.plist and secrets excluded

### Build Configurations
- **Debug**: Development Firebase project, verbose logging
- **Release**: Production Firebase project, optimized builds
- **Package Dependencies**: Different targets for different features

## Image & Media Handling

### Image Upload Pipeline
```swift
// Cloudinary service pattern
public func uploadProfileImage(_ image: UIImage, userId: String) async throws -> String {
    // Image compression (0.7 quality)
    // Cloudinary upload with preset
    // URL return for storage
}
```

### Camera Integration
- **AVFoundation**: Camera capture for gesture recognition
- **UIViewControllerRepresentable**: Camera view bridge to SwiftUI
- **Image Processing**: Real-time processing for ML model input

## Performance & Optimization

### Memory Management
- **Weak References**: Used in closures and delegates to prevent retain cycles
- **Async/Await**: Preferred over completion handlers for better memory management
- **Image Optimization**: JPEG compression before upload

### ML Model Performance
- **Model Bundling**: yolo.mlmodel included in Play package resources
- **Inference Optimization**: Real-time camera feed processing
- **Memory Efficiency**: Proper image buffer management

## Accessibility Implementation

### VoiceOver Support
- Semantic UI elements with proper accessibility labels
- Navigation hints for gesture-based interactions
- Alternative text for images and visual content

### Inclusive Design
- High contrast color support through SQColor system
- Dynamic type size support
- Gesture alternatives for users with motor impairments

## Analytics & Monitoring

### Firebase Analytics
- User engagement tracking
- Feature usage analytics
- Performance monitoring
- Crash reporting through Crashlytics

### Debug Logging
- Structured logging with emoji prefixes (🏁, ✅, ❌, ⚠️)
- Network request/response logging
- State change tracking in managers and ViewModels

## Testing Patterns

### Mock Services
```swift
class MockUserManager: ObservableObject {
    @Published var authUser: FirebaseAuth.User?
    @Published var firestoreUser: SQUser?
    // Mock implementation for testing
}
```

### Test Structure
- **Unit Tests**: Service layer and business logic
- **Integration Tests**: Firebase integration testing
- **UI Tests**: SwiftUI view testing with mock data
- **ML Tests**: YOLO model accuracy validation

## Security Best Practices

### Data Protection
- **Firebase Security Rules**: Server-side data validation
- **Authentication Requirements**: Protected routes and data access
- **Image Upload Security**: Preset-based Cloudinary uploads
- **API Key Management**: Secure secret storage

### Privacy Compliance
- **Camera Permissions**: Explicit user consent for camera access
- **Data Minimization**: Only collect necessary user data
- **User Control**: Account deletion and data removal options

## Development Workflow Enhancements

### Code Organization Rules
- **Feature Isolation**: Each feature is a separate Swift package
- **Dependency Direction**: Features depend on Core, never on each other
- **Protocol-Based Design**: SignQuestInterfaces defines contracts
- **Shared Models**: SignQuestModels package for cross-feature data structures

### Common Debugging Scenarios
- **Camera Not Working**: Check Info.plist permissions, verify AVFoundation setup
- **ML Model Errors**: Ensure yolo.mlmodel is in bundle resources
- **Firebase Errors**: Verify GoogleService-Info.plist, check network connectivity
- **Navigation Issues**: Debug coordinator state, check environmentObject injection
- **Image Upload Failures**: Verify Cloudinary configuration, check network permissions

### Performance Monitoring
- **Build Times**: Modular architecture reduces compile times
- **Runtime Performance**: Firebase Performance Monitoring integration
- **Memory Usage**: Profile camera and ML model memory consumption
- **Battery Impact**: Monitor location and camera usage impact

This comprehensive guide provides GitHub Copilot with detailed context about Sign Quest's architecture, patterns, and best practices for more accurate code suggestions and contextual understanding.