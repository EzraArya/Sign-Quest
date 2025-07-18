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

This guide should help GitHub Copilot understand the Sign Quest project structure, patterns, and conventions to provide more accurate and contextually appropriate code suggestions.