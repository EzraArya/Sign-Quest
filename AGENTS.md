# Sign Quest - AI Agent Guidelines

> Sign language learning game for iOS with AI-powered gesture recognition.

## Quick Reference

| Stack | Technology |
|-------|------------|
| UI | SwiftUI (iOS 16+) |
| Language | Swift 6.1 |
| Database | Firebase Firestore |
| Auth | Firebase Authentication |
| ML | YOLO (Ultralytics) for gesture detection |
| Architecture | SPM Modular Packages, MVVM + Coordinator |

---

## Architecture Overview

### Module Structure

```
Sign Quest/
├── App/                          # Entry point, AppCoordinator
├── Core/Packages/
│   ├── SignQuestCore/            # Managers, Services
│   ├── SignQuestModels/          # Data models (Firestore-compatible)
│   ├── SignQuestInterfaces/      # Shared protocols
│   └── SignQuestUI/              # Shared UI components
└── Features/                     # Feature modules (SPM packages)
    ├── Authentication/           # Login, Register, Greet flows
    ├── Dashboard/                # Tab-based container
    ├── Home/                     # Level selection
    ├── Leaderboard/              # Rankings
    ├── Onboarding/               # First-time user experience
    ├── Play/                     # Game with ML gesture detection
    └── Profile/                  # User settings
```

### Feature Module Structure

Each feature follows this pattern:
```
Feature/
├── Package.swift
├── Sources/Feature/
│   ├── Data/                     # (optional) Local data handling
│   ├── Service/Network/          # Firebase network calls
│   └── UI/
│       ├── View/                 # SwiftUI Views
│       ├── ViewModel/            # @MainActor ObservableObject
│       └── Coordinator/          # Navigation coordination
└── Tests/
```

---

## State Management

### AppCoordinator (Navigation State Machine)

Location: `App/AppCoordinator.swift`

The `AppCoordinator` is the **single source of truth** for app-level navigation:

```swift
public enum AppState: Equatable {
    case onboarding
    case mainFlow
    case login
    case register
    case play(levelId: String)
    case greet
}

@MainActor
public class AppCoordinator: AppCoordinatorProtocol {
    @Published public var appState: AppState
    // ...
}
```

**State Flow:**
1. **onboarding** → First launch, intro screens
2. **login/register** → Authentication
3. **greet** → Welcome back screen (after auth)
4. **mainFlow** → Dashboard with tabs (Home, Leaderboard, Profile)
5. **play** → Active game session

### ViewModels

All ViewModels use:
- `@MainActor` for thread safety
- `ObservableObject` with `@Published` properties
- Prefix: `SQ*ViewModel` (e.g., `SQHomeViewModel`)

```swift
@MainActor
class SQGamesViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var currentQuestion: SQQuestion?
    // ...
}
```

### UserManager (Auth + User State)

Location: `SignQuestCore/Managers/UserManager.swift`

Singleton managing authentication and user data:
- `authUser` — Firebase Auth user
- `firestoreUser` — SQUser from Firestore
- Real-time Firestore listener for profile updates

---

## Firebase Data Flow

### Firestore Collections

| Collection | Document Fields | Purpose |
|------------|-----------------|---------|
| `users` | id, name, email, image, xp, createdAt | User profiles |
| `levels` | id, sectionId, name, minScore, order | Game levels |
| `questions` | id, levelId, type, content, correctAnswerIndex | Quiz questions |
| `sections` | id, name, order | Level groups |
| `users/{uid}/levelData` | levelId, highScore, isCompleted | User progress (subcollection) |

### Network Service Pattern

Each feature has its own `*NetworkService`:

```swift
protocol SQPlayNetworkServiceProtocol {
    func fetchLevel(levelId: String) async throws -> SQLevel
    func fetchQuestions(levelId: String) async throws -> [SQQuestion]
}

struct SQPlayNetworkService: SQPlayNetworkServiceProtocol, Sendable {
    func fetchLevel(levelId: String) async throws -> SQLevel {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("levels").document(levelId).getDocument()
        return try snapshot.data(as: SQLevel.self)
    }
}
```

### Data Models

All models in `SignQuestModels` use `@DocumentID` for Firestore compatibility:

```swift
import FirebaseFirestore

struct SQUser: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var image: String?
    // ...
}
```

---

## ML/Gesture Recognition Integration

### Overview

The Play feature uses **YOLO** (from `ultralytics/yolo-ios-app`) for sign language gesture detection.

### Key Files

| File | Purpose |
|------|---------|
| `Play/Model/yolo.mlmodel` | Trained gesture detection model |
| `SQGamesTypeThreePageViewModel.swift` | ML processing logic |
| `SQGamesTypeThreePage.swift` | Camera UI + gesture feedback |

### Detection Flow

```
Camera Input → UIImage → YOLO Model → YOLOResult → Top Detection → Verify Answer
```

```swift
class SQGamesTypeThreeViewModel: ObservableObject {
    private let yolo = YOLO("yolo", task: .detect)
    @Published var yoloResult: YOLOResult?
    
    func processImageWithYolo(_ image: UIImage) {
        yoloResult = yolo(image)
    }
    
    func getTopDetection() -> (label: String, confidence: Int)? {
        if let topBox = yoloResult?.boxes.max(by: { $0.conf < $1.conf }) {
            return (topBox.cls, Int(topBox.conf * 100))
        }
        return nil
    }
}
```

### Question Types

```swift
enum SQQuestionType: String, Codable {
    case selectAlphabet   // Multiple choice: select letter
    case selectGesture    // Multiple choice: select gesture image
    case performGesture   // Camera: perform the gesture
}
```

---

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Models | `SQ*` | `SQUser`, `SQLevel`, `SQQuestion` |
| ViewModels | `SQ*ViewModel` | `SQHomeViewModel` |
| Views | `SQ*View` / `SQ*Page` | `SQHomeView`, `SQGamesTypeThreePage` |
| Coordinators | `SQ*Coordinator` | `SQPlayCoordinator` |
| Network Services | `SQ*NetworkService` | `SQPlayNetworkService` |

---

## Common Tasks

### Adding a New Feature Module

1. Create folder: `Features/NewFeature/`
2. Add `Package.swift` with dependencies
3. Create standard structure: `Sources/NewFeature/UI/`, `Service/`, `Tests/`
4. Add to main project's package dependencies

### Adding a New Screen

1. Create View in `UI/View/`
2. Create ViewModel in `UI/ViewModel/`
3. Add navigation case to feature's Coordinator
4. Wire up in the coordinator's navigation switch

### Adding a New Data Model

1. Create in `SignQuestModels/Sources/`
2. Conform to `Codable, Identifiable`
3. Use `@DocumentID` for Firestore ID field
4. Update relevant NetworkService to fetch/save

---

## Security Notes

> [!CAUTION]
> These files are **gitignored** and must be configured locally:

| File | Purpose |
|------|---------|
| `Core/GoogleService-Info.plist` | Firebase configuration |
| `SignQuestCore/Secret/Secret.swift` | Doppler service token |

Cloudinary credentials are fetched at runtime via Doppler (see `SecretManager.swift`).

---

## Build & Test

```bash
# Open project
open "Sign Quest.xcworkspace"

# Run tests
xcodebuild test -workspace "Sign Quest.xcworkspace" \
  -scheme "Sign Quest" \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

---

## Known Issues

- **Duplicate ML model**: `yolo.mlmodel` exists in both `Core/Model/` and `Play/Model/`
- **Empty test files**: Test stubs exist but lack implementation
- **Debug prints**: Production code contains `print()` statements (should use `os.Logger`)
