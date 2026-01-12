# 🤟 Sign Quest

An interactive sign language learning game for iOS with AI-powered gesture recognition.

<p align="center">
  <img src="https://img.shields.io/badge/iOS-16%2B-blue" alt="iOS 16+">
  <img src="https://img.shields.io/badge/Swift-6.1-orange" alt="Swift 6.1">
  <img src="https://img.shields.io/badge/SwiftUI-4-purple" alt="SwiftUI">
  <img src="https://img.shields.io/badge/Core_ML-Gesture_Recognition-green" alt="Core ML">
</p>

## ✨ Features

- **Real-time Gesture Recognition** — AI-powered sign language detection using Core ML
- **Interactive Learning** — Gamified experience with levels, questions, and progress tracking
- **Leaderboard System** — Compete and track your progress against others
- **User Profiles** — Personalized learning experience with progress saved to the cloud
- **Beautiful Dark UI** — Modern SwiftUI interface optimized for dark mode

## 🏗️ Architecture

Sign Quest uses a **modular Swift Package Manager architecture** with feature-based modules:

```
Sign Quest/
├── App/                          # Main app entry and coordination
├── Core/
│   └── Packages/
│       ├── SignQuestCore/        # Business logic, managers, services
│       ├── SignQuestModels/      # Data models with Firebase integration
│       ├── SignQuestInterfaces/  # Protocols and shared interfaces
│       └── SignQuestUI/          # Shared UI components
└── Features/                     # Feature modules (SPM packages)
    ├── Authentication/           # Login/Register flows
    ├── Dashboard/                # Main dashboard
    ├── Home/                     # Home screen
    ├── Onboarding/               # First-time user experience
    ├── Play/                     # Game/learning functionality
    ├── Profile/                  # User profile management
    └── Leaderboard/              # Competition and scoring
```

### Key Patterns
- **MVVM + Coordinator** — Clean separation of concerns with navigation coordination
- **Protocol-Oriented** — Dependency injection for testability
- **Async/Await** — Modern Swift concurrency throughout

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| UI | SwiftUI (iOS 16+) |
| Language | Swift 6.1 |
| Database | Firebase Firestore |
| Auth | Firebase Authentication |
| ML | Core ML (YOLO model) |
| Architecture | SPM Modular Packages |
| Secret Management | Doppler |

## 📋 Requirements

- iOS 16.0+
- Xcode 16+
- Swift 6.1+
- Firebase account (for Auth & Firestore)
- Doppler account (for secrets management)

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/sign-quest.git
cd sign-quest
```

### 2. Configure Secrets

This project uses **Doppler** for secret management. You need to create two files that are gitignored:

**`Sign Quest/Core/GoogleService-Info.plist`**
- Download from your Firebase console

**`Sign Quest/Core/Packages/SignQuestCore/Sources/SignQuestCore/Secret/Secret.swift`**
```swift
import Foundation

enum Secret {
    static let dopplerServiceToken = "your-doppler-service-token"
}
```

### 3. Open in Xcode
```bash
open "Sign Quest.xcworkspace"
```

### 4. Build & Run
Select your target device/simulator and press `⌘R`

## 🔐 Security

- **Secrets are gitignored** — `Secret.swift` and `GoogleService-Info.plist` are not committed
- **Runtime fetching** — Cloudinary credentials are fetched at runtime via Doppler
- **Firebase Rules** — Backend protected by Firestore security rules

## 📁 Project Structure

| Path | Description |
|------|-------------|
| `App/AppCoordinator.swift` | Main app state and navigation |
| `Core/.../Managers/` | Business logic managers (User, Level, Secret) |
| `Core/.../Models/` | Data models (SQUser, SQLevel, SQQuestion) |
| `Features/Play/` | Core gameplay with ML gesture recognition |

## 🧪 Testing

```bash
# Run unit tests
xcodebuild test -workspace "Sign Quest.xcworkspace" -scheme "Sign Quest" -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 📄 License

This project is proprietary software. All rights reserved.

---

<p align="center">
  Made with ❤️ for sign language learners
</p>
