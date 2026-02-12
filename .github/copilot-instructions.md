# Sign Quest - iOS Sign Language Learning App

**CRITICAL: Always follow these instructions first and fallback to additional search and context gathering only if the information here is incomplete or found to be in error.**

Sign Quest is an iOS sign language learning application built with Swift 6.1, SwiftUI, Firebase, and Core ML. The app uses AI-powered gesture recognition to provide interactive sign language learning experiences.

## Platform Requirements

**CRITICAL LIMITATION: This project ONLY builds and runs on macOS with Xcode installed. DO NOT attempt to build on Linux or Windows.**

- **Required**: macOS 13+ with Xcode 15.0+
- **Target Platform**: iOS 16.0+
- **Swift Version**: 6.1+
- **Architecture**: Modular Swift Package Manager with feature-based modules

## Project Structure

```
Sign Quest/
├── App/                          # Main app entry point
│   ├── Sign_QuestApp.swift      # SwiftUI App with Firebase configuration
│   ├── AppCoordinator.swift     # Main app state management
│   └── AppDelegate.swift        # UIKit delegate setup
├── Core/                        # Shared core functionality (Swift Packages)
│   └── Packages/
│       ├── SignQuestCore/       # Business logic, managers, services
│       ├── SignQuestModels/     # Data models with Firebase integration
│       ├── SignQuestInterfaces/ # Protocols and shared interfaces
│       └── SignQuestUI/         # Shared UI components
└── Features/                    # Feature modules (Swift Packages)
    ├── Authentication/          # Login/Register flows
    ├── Dashboard/              # Main dashboard
    ├── Home/                   # Home screen
    ├── Onboarding/            # First-time user experience
    ├── Play/                  # Game/learning functionality
    ├── Profile/               # User profile management
    └── Leaderboard/           # Competition and scoring
```

## Building and Running

### Bootstrap the Project

**NEVER CANCEL these operations - they may take 45+ minutes. Set timeouts to 60+ minutes minimum.**

1. Open the project:
   ```bash
   open "Sign Quest.xcworkspace"
   ```

2. **NEVER CANCEL: Build takes 30-45 minutes on first run. Set timeout to 60+ minutes.**
   - In Xcode: Product → Build (⌘+B)
   - Or via command line:
   ```bash
   xcodebuild -workspace "Sign Quest.xcworkspace" -scheme "Sign Quest" -configuration Debug build
   ```

3. **NEVER CANCEL: Running takes 10-15 minutes for simulator startup. Set timeout to 30+ minutes.**
   - Select iOS Simulator target (iPhone 15 Pro recommended)
   - Product → Run (⌘+R)

### Dependencies

The project uses Swift Package Manager with these key dependencies:
- **Firebase SDK 11.14.0+**: Authentication, Firestore, Analytics, Crashlytics
- **Cloudinary 5.0.0+**: Image and media management
- **Local packages**: All feature and core modules

Dependencies are automatically resolved by Xcode. **NEVER CANCEL dependency resolution - can take 15-20 minutes.**

## Testing

### Unit Tests
**NEVER CANCEL: Test suite takes 20-30 minutes. Set timeout to 45+ minutes.**

```bash
# Run all tests
xcodebuild -workspace "Sign Quest.xcworkspace" -scheme "Sign Quest" -destination 'platform=iOS Simulator,name=iPhone 15 Pro' test

# Run specific package tests
cd "Sign Quest/Core/Packages/SignQuestCore"
swift test  # NOTE: Will fail on non-macOS due to iOS dependencies

# Run main app tests
xcodebuild -workspace "Sign Quest.xcworkspace" -scheme "Sign Quest" -destination 'platform=iOS Simulator,name=iPhone 15 Pro' test -only-testing:"Sign QuestTests"
```

### UI Tests
**NEVER CANCEL: UI tests take 30-45 minutes. Set timeout to 60+ minutes.**

```bash
xcodebuild -workspace "Sign Quest.xcworkspace" -scheme "Sign Quest" -destination 'platform=iOS Simulator,name=iPhone 15 Pro' test -only-testing:"Sign QuestUITests"
```

### Test Framework
- Uses Swift Testing framework (not XCTest)
- Tests are structured with `@Test` annotations
- Import with `@testable import Sign_Quest` for main app tests

## Manual Validation Scenarios

**CRITICAL: After making any changes, ALWAYS test these complete user scenarios:**

### 1. Onboarding and Authentication Flow (5-10 minutes)
- Launch app and complete onboarding
- Create new user account or log in
- Verify Firebase authentication works
- Check user profile creation

### 2. Core Learning Experience (10-15 minutes)
- Navigate to Play feature
- Start a sign language lesson
- Test camera permissions and Core ML gesture recognition
- Complete at least one full question cycle
- Verify progress tracking and scoring

### 3. Social Features (5 minutes)
- Check leaderboard functionality
- Verify user progress display
- Test profile management features

### 4. Accessibility Testing (10 minutes)
- Enable VoiceOver and test navigation
- Test with Dynamic Type (large text)
- Verify contrast in both light and dark modes
- Test gesture recognition with accessibility features

## Linting and Code Quality

**ALWAYS run these before committing changes:**

```bash
# Format code (takes 2-3 minutes)
swiftformat .

# Lint code (takes 3-5 minutes)
swiftlint

# Check for accessibility issues
# Use Xcode Accessibility Inspector manually
```

## Firebase Configuration

The app requires Firebase configuration files:
- `Sign Quest/Core/GoogleService-Info.plist` (gitignored for security)
- Firebase project must have Authentication, Firestore, and Analytics enabled
- **NEVER commit GoogleService-Info.plist or API keys**
- App initialization: `FirebaseApp.configure()` is called in `Sign_QuestApp.swift`
- Data models use `@DocumentID` and `@ServerTimestamp` property wrappers
- All models conform to `Codable`, `Hashable`, `Identifiable`, and `@unchecked Sendable`

## Core ML Model

The app uses `yolo.mlmodel` for sign language gesture recognition:
- Model is loaded asynchronously on app launch
- Camera integration requires device permissions
- **Performance critical**: Test on physical device for accurate ML performance

## Development Workflow

### Making Changes
1. **ALWAYS build and test before starting** to establish baseline
2. Make minimal, focused changes to specific modules
3. **Build incrementally** after each change (15-20 minutes per build)
4. **Test affected features manually** using validation scenarios above
5. **Run linting and unit tests** before committing

### Package Development
- Each feature is an independent Swift Package
- Use `SQ` prefix for all custom types (e.g., `SQUser`, `SQLevel`)
- Follow coordinator pattern for navigation
- Use protocol-oriented design for testability

### Architecture Patterns
- **Coordinator Pattern**: Navigation management (e.g., `SQHomeCoordinator`)
- **Manager Pattern**: Business logic singletons (e.g., `LevelManager`, `UserManager`)
- **MVVM**: ViewModels for business logic, Views for UI
- **Protocol-Oriented**: Heavy use of protocols for dependency injection

## Common Issues and Solutions

### Build Failures
- **"No such module 'SwiftUI'"**: Only occurs on non-macOS platforms - ensure you're on macOS with Xcode
- **Firebase compilation errors**: Check GoogleService-Info.plist is present and valid
- **Package resolution failures**: Delete derived data and retry (takes 10-15 minutes)

### Runtime Issues
- **Camera not working**: Check privacy permissions in iOS Settings
- **Firebase auth failures**: Verify network connection and Firebase configuration
- **Core ML crashes**: Test on physical device, simulator has limited ML capabilities

## Performance Considerations

- **ML Model Loading**: Takes 5-10 seconds on first launch
- **Firebase Queries**: Implement offline caching for better UX
- **Memory Usage**: Monitor during extended learning sessions
- **Battery Impact**: Core ML and camera usage are power-intensive

## Key Files for Common Tasks

### User Management
- `/Sign Quest/Core/Packages/SignQuestCore/Sources/SignQuestCore/Managers/UserManager.swift`

### Level and Content Management  
- `/Sign Quest/Core/Packages/SignQuestCore/Sources/SignQuestCore/Managers/LevelManager.swift`

### Main App Coordination
- `/Sign Quest/App/AppCoordinator.swift`

### Data Models
- `/Sign Quest/Core/Packages/SignQuestModels/Sources/SignQuestModels/`

### UI Components
- `/Sign Quest/Core/Packages/SignQuestUI/Sources/SignQuestUI/`

## Security and Privacy

- **NEVER expose Firebase API keys** in client code
- **User data privacy**: App handles camera data and learning progress
- **Child safety**: Consider COPPA compliance for underage users
- **Accessibility**: VoiceOver support is mandatory for sign language learners

## Accessibility Requirements

**CRITICAL for sign language app:**
- Provide `accessibilityLabel`, `accessibilityHint` for all interactive elements
- Support VoiceOver navigation
- Maintain WCAG AA contrast ratios (4.5:1)
- Support Dynamic Type for text scaling
- Test with accessibility features enabled
- Provide haptic feedback for gesture recognition results

## Platform Limitations

**CRITICAL: Commands that CANNOT be validated on non-macOS platforms:**

### Will Fail on Linux/Windows:
- `xcodebuild` - Xcode build system not available
- `swift test` for iOS packages - Missing SwiftUI and iOS frameworks
- iOS Simulator launch - iOS runtime not available
- Xcode-specific tools (Instruments, Interface Builder, etc.)

### Build Time Estimates (macOS with Xcode only):
- **Initial build**: 30-45 minutes (NEVER CANCEL - set 60+ minute timeout)
- **Incremental builds**: 15-20 minutes per module change
- **Dependency resolution**: 15-20 minutes (NEVER CANCEL)
- **Full test suite**: 45-60 minutes (NEVER CANCEL)
- **UI test suite**: 30-45 minutes (NEVER CANCEL)
- **Clean build**: 45-60 minutes (NEVER CANCEL)

## Release Process

1. **NEVER CANCEL: Full test suite takes 45-60 minutes**
2. Build for release configuration (adds 10-15 minutes to build time)
3. Archive and validate with App Store Connect
4. Submit for TestFlight beta testing
5. Monitor crash reports and performance metrics

---

**REMEMBER: This is an educational accessibility app. Every change must consider the learning experience and diverse abilities of sign language learners.**