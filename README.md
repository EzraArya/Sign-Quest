# Sign Quest 🤟

**Sign Quest** is an interactive iOS app designed to make learning sign language fun and engaging through gamified lessons and real-time gesture recognition.

## 📱 Features

### Core Learning Experience
- **Interactive Questions**: Multiple question types including alphabet selection, gesture identification, and gesture performance
- **Real-time Gesture Recognition**: Uses advanced ML models to recognize and validate sign language gestures
- **Progressive Learning**: Structured levels that build upon each other for systematic learning
- **Gamified Experience**: Score tracking, progress monitoring, and achievement systems

### User Experience
- **User Authentication**: Secure Firebase-based authentication system
- **Personal Profiles**: Track your learning progress and achievements
- **Leaderboard**: Compete with other learners and see your ranking
- **Intuitive Dashboard**: Easy navigation and progress overview

## 🛠 Technical Stack

- **Platform**: iOS 17.0+
- **Framework**: SwiftUI
- **Backend**: Firebase (Authentication, Firestore)
- **Machine Learning**: Core ML with YOLO model for gesture recognition
- **Architecture**: Modular Swift Package Manager architecture
- **Development**: Xcode 15.0+

## 📁 Project Structure

```
Sign Quest/
├── Sign Quest/                    # Main app module
│   ├── App/                      # App configuration and delegates
│   ├── Core/                     # Core resources and packages
│   │   ├── Assets.xcassets       # Images and color assets
│   │   ├── Fonts/                # Custom font files
│   │   └── Packages/             # Core Swift packages
│   │       ├── SignQuestCore/    # Core business logic
│   │       ├── SignQuestUI/      # Shared UI components
│   │       ├── SignQuestModels/  # Data models
│   │       └── SignQuestInterfaces/ # Protocol definitions
│   └── Features/                 # Feature modules
│       ├── Authentication/       # User login/registration
│       ├── Onboarding/          # App introduction
│       ├── Home/                # Main navigation
│       ├── Dashboard/           # Progress overview
│       ├── Play/                # Core learning experience
│       ├── Leaderboard/         # Rankings and competition
│       └── Profile/             # User management
├── Sign QuestTests/             # Unit tests
└── Sign QuestUITests/           # UI tests
```

## 🚀 Getting Started

### Prerequisites

- macOS 14.0 or later
- Xcode 15.0 or later
- iOS 17.0+ device or simulator
- Active Apple Developer account (for device testing)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/EzraArya/Sign-Quest.git
   cd Sign-Quest
   ```

2. **Open the project**
   ```bash
   open "Sign Quest.xcworkspace"
   ```

3. **Install dependencies**
   
   The project uses Swift Package Manager. Dependencies will be automatically resolved when you build the project:
   - Firebase iOS SDK
   - YOLO iOS App (for gesture recognition)

4. **Configure Firebase**
   - Add your `GoogleService-Info.plist` file to the project
   - Ensure Firebase Authentication and Firestore are enabled in your Firebase console

5. **Build and run**
   - Select your target device or simulator
   - Build and run the project (⌘+R)

## 🎮 How to Use

1. **Getting Started**
   - Launch the app and complete the onboarding process
   - Create an account or sign in with existing credentials

2. **Learning Process**
   - Navigate to the Play section to start learning
   - Progress through levels with increasing difficulty
   - Complete different types of questions:
     - **Select Alphabet**: Choose the correct letter for a given gesture
     - **Select Gesture**: Identify the correct gesture for a given prompt
     - **Perform Gesture**: Perform the sign language gesture for recognition

3. **Track Progress**
   - View your progress on the Dashboard
   - Check your ranking on the Leaderboard
   - Update your profile and view achievements

## 🏗 Architecture

Sign Quest uses a modular architecture with separate Swift packages for different concerns:

- **SignQuestCore**: Business logic, services, and utilities
- **SignQuestModels**: Data models and structures
- **SignQuestUI**: Reusable UI components and themes
- **SignQuestInterfaces**: Protocol definitions and contracts

Each feature (Authentication, Play, Leaderboard, etc.) is implemented as a separate Swift package, promoting code reusability and maintainability.

## 🤖 Machine Learning

The app integrates Core ML for gesture recognition:
- **Model**: YOLO-based model trained for sign language gesture detection
- **Real-time Processing**: Camera input processing for live gesture recognition
- **Accuracy**: Optimized for real-time performance on iOS devices

## 🧪 Testing

Run tests using Xcode's testing framework:

```bash
# Run all tests
⌘+U in Xcode

# Or use command line
xcodebuild test -workspace "Sign Quest.xcworkspace" -scheme "Sign Quest"
```

## 🤝 Contributing

We welcome contributions to Sign Quest! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
   - Follow the existing code style and architecture
   - Add tests for new functionality
   - Update documentation as needed
4. **Commit your changes**
   ```bash
   git commit -m "Add your descriptive commit message"
   ```
5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
6. **Open a Pull Request**

### Code Style Guidelines

- Follow Swift naming conventions
- Use SwiftUI best practices
- Maintain the modular architecture
- Include appropriate documentation and comments
- Ensure all tests pass before submitting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Ezra Arya Wijaya** - *Initial work* - [EzraArya](https://github.com/EzraArya)

## 🙏 Acknowledgments

- Firebase team for the excellent backend services
- Ultralytics for the YOLO machine learning framework
- The sign language community for inspiration and guidance
- All contributors who help make this project better

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/EzraArya/Sign-Quest/issues) page
2. Create a new issue with detailed information
3. Contact the maintainers

---

**Happy Learning! 🌟**

Learn sign language in a fun, interactive way with Sign Quest. Every gesture counts towards building a more inclusive world.