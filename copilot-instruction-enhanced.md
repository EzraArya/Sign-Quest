# Copilot Instructions for Sign Quest

## PROJECT CONTEXT
- **Project name**: Sign Quest
- **Technology stack**: Swift 6.1, SwiftUI, Firebase (Firestore, Auth), Core ML, iOS 16+
- **Project purpose**: Interactive sign language learning game with AI-powered gesture recognition
- **Target audience**: Sign language learners using iOS devices
- **Architecture**: Modular Swift Package Manager architecture with feature-based modules

## CODEBASE STRUCTURE

### Core Architecture
```
Sign Quest/
├── App/                          # Main app entry point and coordination
│   ├── Sign_QuestApp.swift      # SwiftUI App with Firebase configuration
│   ├── AppCoordinator.swift     # Main app state management and navigation
│   └── AppDelegate.swift        # UIKit delegate for additional setup
├── Core/                        # Shared core functionality
│   └── Packages/
│       ├── SignQuestCore/       # Business logic, managers, services
│       ├── SignQuestModels/     # Data models with Firebase integration
│       ├── SignQuestInterfaces/ # Protocols and shared interfaces
│       └── SignQuestUI/         # Shared UI components
└── Features/                    # Feature modules (SPM packages)
    ├── Authentication/          # Login/Register flows
    ├── Dashboard/              # Main dashboard
    ├── Home/                   # Home screen
    ├── Onboarding/            # First-time user experience
    ├── Play/                  # Game/learning functionality
    ├── Profile/               # User profile management
    └── Leaderboard/           # Competition and scoring
```

### Key Architectural Patterns
- **Coordinator Pattern**: Each feature has a coordinator for navigation (e.g., `SQHomeCoordinator`)
- **Manager Pattern**: Singleton managers for core functionality (e.g., `LevelManager`, `UserManager`)
- **Protocol-Oriented**: Heavy use of protocols for dependency injection and testability
- **MVVM with Coordinators**: ViewModels handle business logic, Coordinators manage navigation

### Data Layer
- **Firebase Firestore**: Primary database with `@DocumentID` and `@ServerTimestamp` property wrappers
- **Core ML**: Local model for sign language recognition (`yolo.mlmodel`)
- **UserDefaults**: Local preferences via `UserDefaultsManager`

## CODING STANDARDS

### Swift Conventions
- **Naming**: Use `SQ` prefix for all custom types (e.g., `SQUser`, `SQLevel`, `SQLeaderboard`)
- **Access Control**: Mark classes as `public` for cross-module access, `private` for internal logic
- **Concurrency**: Use `async/await` for network operations, mark managers as `@unchecked Sendable`
- **Property Wrappers**: 
  - `@DocumentID` for Firebase document IDs
  - `@ServerTimestamp` for Firebase timestamps
  - `@Published` for observable properties
  - `@StateObject` for view ownership of ObservableObjects

### File Organization
- **Headers**: Always include file path comment and creation date
- **Imports**: Group by framework type (Foundation, SwiftUI, Firebase, Custom)
- **Structure**: Protocol → Implementation → Extensions

### SwiftUI Patterns
- Use `@MainActor` for UI-related coordinators and view models
- Prefer `@StateObject` for ownership, `@ObservedObject` for dependency injection
- Environment objects for app-wide state (`userManager`, `appCoordinator`)
- Navigation via `NavigationPath` and coordinator pattern

## DEVELOPMENT WORKFLOW

### Package Structure
- Each feature is a separate Swift Package with its own `Package.swift`
- Minimum iOS deployment target: iOS 16
- Core packages are dependencies for feature packages
- Test targets included for each package

### Firebase Integration
- Models conform to `Codable` and use Firebase property wrappers
- All models implement `Hashable`, `Identifiable`, and `@unchecked Sendable`
- Network services handle Firebase operations with proper error handling

### State Management
- `AppCoordinator` manages overall app state with `AppState` enum
- Feature coordinators manage local navigation state
- User state managed through `UserManager` singleton

## SPECIFIC INSTRUCTIONS

### Always:
- Use the `SQ` prefix for all custom types and components
- Include proper error handling for async operations
- Mark classes as `@unchecked Sendable` when needed for concurrency
- Use coordinator pattern for navigation between screens
- Include file headers with creation date and author
- Implement protocols before concrete types
- Use dependency injection through initializers

### Never:
- Access Firebase directly from Views - always go through managers/services
- Use forced unwrapping without proper error handling
- Create UI components without considering dark mode (app uses `.preferredColorScheme(.dark)`)
- Bypass the coordinator pattern for navigation
- Create singletons without thread safety considerations

### When suggesting changes:
- Always consider the modular package architecture
- Suggest protocol-first approaches for new functionality
- Include proper async/await patterns for network operations
- Consider Firebase data modeling constraints
- Respect the existing coordinator navigation patterns

### For new features:
- Create as separate Swift Package in `Features/` directory
- Include coordinator, network service, and UI components
- Follow the established naming conventions with `SQ` prefix
- Add proper package dependencies in `Package.swift`
- Include test targets and basic test coverage

## CONTEXT AWARENESS

### Key Business Logic Locations
- **User Management**: `/Core/Packages/SignQuestCore/Sources/SignQuestCore/Managers/UserManager.swift`
- **Level Management**: `/Core/Packages/SignQuestCore/Sources/SignQuestCore/Managers/LevelManager.swift`
- **App Coordination**: `/App/AppCoordinator.swift`
- **Data Models**: `/Core/Packages/SignQuestModels/Sources/SignQuestModels/`

### Common Patterns in Codebase
- Coordinator protocol implementation: `NavigationCoordinatorProtocol`
- Network service protocols ending with `Protocol` (e.g., `LevelServiceProtocol`)
- Firebase models with `@DocumentID` and `@ServerTimestamp`
- Async manager methods using `private` for internal logic, `public` for external access
- SwiftUI views with environment object injection

### External Dependencies
- **Firebase SDK**: Authentication, Firestore database, server timestamps
- **Core ML**: For sign language gesture recognition
- **SwiftUI**: Primary UI framework with iOS 16+ features
- **Combine**: For reactive programming and state management

### App States and Flow
- **Onboarding** → **Authentication** → **Main Flow** (Dashboard/Home) → **Play** → **Profile/Leaderboard**
- State transitions managed through `AppCoordinator.appState`
- User authentication state checked on app launch via Firebase Auth

### Data Models Structure
- `SQUser`: User profile with Firebase integration
- `SQLevel`: Learning level configuration
- `SQQuestion`: Individual learning questions
- `SQGameSession`: Play session tracking
- `SQUserLevelData`: Progress tracking per user per level

### ML Integration
- Core ML model (`yolo.mlmodel`) for sign recognition
- Integrated into Play feature for real-time gesture detection
- Consider performance implications when suggesting ML-related changes

## PERFORMANCE GUIDELINES

### Memory Management
- Use `weak` references in closures to prevent retain cycles
- Implement `deinit` for cleanup in managers and coordinators
- Monitor memory usage during ML model inference
- Use lazy loading for heavy resources and images
- Consider using `@StateObject` vs `@ObservedObject` impact on view lifecycle

### Core ML Optimization
- Load ML models asynchronously on background queues
- Cache model predictions when appropriate
- Use prediction batching for multiple inference requests
- Monitor model performance and frame rates during camera operations
- Consider model quantization for smaller binary size

### SwiftUI Performance
- Use `@State` and `@StateObject` judiciously to minimize view updates
- Implement `Equatable` for complex data types passed to views
- Use `LazyVStack`/`LazyHStack` for large lists
- Avoid heavy computations in view body - move to computed properties or methods
- Profile with Instruments for view update frequency

### Network & Firebase
- Implement proper caching strategies for Firestore queries
- Use offline persistence for critical user data
- Batch Firestore operations when possible
- Implement exponential backoff for failed requests
- Monitor Firebase quota usage and optimize queries

## ACCESSIBILITY & INCLUSIVITY

### Accessibility Requirements
- **Critical**: This is a sign language app - accessibility is paramount
- Always provide `accessibilityLabel`, `accessibilityHint`, and `accessibilityValue`
- Support VoiceOver navigation and gestures
- Ensure minimum touch target size of 44x44 points
- Provide haptic feedback for important interactions
- Support Dynamic Type for text scaling
- Test with VoiceOver enabled regularly

### Visual Accessibility
- Maintain WCAG AA contrast ratios (4.5:1 for normal text)
- Support both light and dark mode (app defaults to dark)
- Provide alternative text for all images and icons
- Use semantic colors that adapt to accessibility settings
- Support Reduce Motion preferences

### Sign Language Specific
- Ensure camera preview has sufficient contrast and clarity
- Provide visual feedback for gesture recognition states
- Allow users to repeat gestures without penalty
- Consider different learning abilities and paces
- Provide clear visual cues for correct vs incorrect gestures

## TESTING STRATEGY

### Unit Testing
- Test all manager classes (`LevelManager`, `UserManager`) with mock services
- Test data model serialization/deserialization with Firebase
- Test coordinator navigation logic
- Use dependency injection for testable code
- Aim for 80%+ code coverage on business logic

### Integration Testing
- Test Firebase integration with test projects
- Test ML model inference with sample data
- Test coordinator flow between features
- Test network service error handling
- Mock Firebase services for consistent testing

### UI Testing
- Test critical user journeys (onboarding → auth → play)
- Test accessibility compliance with UI tests
- Test gesture recognition flows
- Test navigation coordinator patterns
- Test dark mode and dynamic type support

### Performance Testing
- Profile ML model inference times
- Test memory usage during extended play sessions
- Monitor Firebase query performance
- Test camera and gesture recognition frame rates
- Profile app launch times

## CI/CD PATTERNS

### Build Configuration
- Use different Firebase projects for dev/staging/production
- Configure different bundle identifiers for each environment
- Use build schemes for environment-specific configurations
- Implement automated testing in CI pipeline
- Use fastlane for deployment automation

### Code Quality
- Integrate SwiftLint for consistent code style
- Use SwiftFormat for automated formatting
- Run unit tests automatically on PR creation
- Implement code coverage reporting
- Use static analysis tools for security scanning

### Deployment
- Use TestFlight for beta testing
- Implement feature flags for gradual rollouts
- Monitor crash reports and performance metrics
- Use semantic versioning for releases
- Maintain release notes and changelog

## SECURITY CONSIDERATIONS

### Firebase Security
- Never expose Firebase API keys in client code
- Implement proper Firestore security rules
- Use Firebase Auth for all authenticated requests
- Validate data on both client and server side
- Implement proper user data privacy controls

### Data Protection
- Follow COPPA guidelines for potential underage users
- Implement proper data retention policies
- Provide clear privacy policy and data usage
- Use encrypted storage for sensitive local data
- Implement proper user data deletion

### ML Model Security
- Protect against adversarial inputs to ML model
- Validate camera input before processing
- Implement rate limiting for ML inference
- Monitor for unusual usage patterns
- Secure model files from extraction

## ML/AI INTEGRATION PATTERNS

### Core ML Best Practices
- Use `MLModel` async loading patterns
- Implement proper error handling for model failures
- Cache model instances appropriately
- Use `VNImageRequestHandler` for vision processing
- Monitor model performance metrics

### Camera Integration
- Request camera permissions with clear explanations
- Handle camera unavailability gracefully
- Implement proper camera session lifecycle management
- Provide visual feedback during processing
- Support different device orientations

### Gesture Recognition Flow
```swift
// Preferred pattern for ML integration
class GestureRecognitionService {
    private let model: MLModel
    private let visionModel: VNCoreMLModel
    
    func recognizeGesture(from pixelBuffer: CVPixelBuffer) async throws -> GestureResult {
        // Process with Core ML
        // Return structured result
    }
}
```

## FIREBASE OPTIMIZATION

### Firestore Patterns
- Use compound queries efficiently
- Implement proper indexing for complex queries
- Use subcollections for hierarchical data
- Batch writes for multiple operations
- Implement offline-first patterns

### Real-time Updates
- Use Firestore listeners sparingly
- Implement proper listener cleanup
- Handle connection state changes
- Cache data for offline functionality
- Use Firebase Analytics for user behavior

### Storage Management
- Optimize image and video storage
- Implement progressive loading for media
- Use Firebase Storage security rules
- Monitor storage quota usage
- Implement proper cache invalidation

## ERROR HANDLING PATTERNS

### Network Errors
```swift
// Preferred error handling pattern
enum NetworkError: LocalizedError {
    case noConnection
    case invalidResponse
    case firebaseError(Error)
    
    var errorDescription: String? {
        // Provide user-friendly messages
    }
}
```

### ML Model Errors
- Handle model loading failures gracefully
- Provide fallback options when recognition fails
- Show appropriate user feedback for processing states
- Implement retry mechanisms for transient failures
- Log errors for debugging without exposing sensitive data

### User Experience
- Always provide meaningful error messages
- Implement graceful degradation for feature failures
- Use alerts and banners appropriately
- Provide recovery actions where possible
- Track error frequency for improvement

## LOCALIZATION & INTERNATIONALIZATION

### Text Localization
- Use `NSLocalizedString` for all user-facing text
- Implement proper pluralization rules
- Support RTL languages if expanding globally
- Consider cultural differences in sign language
- Provide context for translators

### Asset Localization
- Localize images with text content
- Consider cultural variations in gestures
- Provide region-specific examples
- Support different date/time formats
- Handle currency and number formatting

## DEBUGGING & MONITORING

### Development Tools
- Use SwiftUI Preview providers for rapid iteration
- Implement proper logging with different levels
- Use Xcode Instruments for performance profiling
- Set up symbolic breakpoints for common issues
- Use View Hierarchy Debugger for layout issues

### Production Monitoring
- Implement Firebase Crashlytics
- Monitor app performance metrics
- Track user engagement and learning progress
- Monitor ML model accuracy in production
- Set up alerts for critical errors

### Analytics
- Track learning completion rates
- Monitor gesture recognition accuracy
- Measure user retention and engagement
- Track feature usage patterns
- Monitor app performance metrics

## DEPENDENCY MANAGEMENT

### Swift Package Manager
- Pin dependency versions for stability
- Regularly update dependencies for security
- Use local packages for modular architecture
- Implement proper dependency injection
- Document package interdependencies

### Third-Party Libraries
- Minimize external dependencies
- Evaluate libraries for accessibility compliance
- Consider package size impact on app bundle
- Monitor for security vulnerabilities
- Have fallback plans for deprecated libraries

## CODE REVIEW GUIDELINES

### What to Look For
- Accessibility implementation completeness
- Memory leak potential in async operations
- Firebase security rule compliance
- ML model performance impact
- Coordinator pattern adherence
- Error handling completeness

### Architecture Reviews
- Package boundary violations
- Protocol vs concrete implementation usage
- Singleton pattern misuse
- SwiftUI state management correctness
- Navigation flow consistency

## DATA PRIVACY & COMPLIANCE

### User Privacy
- Implement clear data collection consent flows
- Provide granular privacy controls
- Enable users to export their data
- Implement secure data deletion
- Document data retention policies

### Learning Data
- Protect gesture/camera data privacy
- Implement on-device processing where possible
- Anonymize learning analytics data
- Provide opt-out mechanisms for data collection
- Consider GDPR compliance for global users

### Child Safety
- Implement age-appropriate content filtering
- Consider parental controls and oversight
- Follow platform guidelines for child safety
- Implement reporting mechanisms for inappropriate content
- Regular security audits for child data protection

Remember: This is an educational app for sign language learning. Every decision should consider the learning experience, accessibility needs, and the diverse abilities of users learning sign language.