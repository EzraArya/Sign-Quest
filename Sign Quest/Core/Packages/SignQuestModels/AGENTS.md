# SignQuestModels Package

> Firestore-compatible data models for the app.

## Dependencies

| Package | Purpose |
|---------|---------|
| FirebaseFirestore | `@DocumentID`, `@ServerTimestamp` property wrappers |

---

## Models

| Model | Purpose | Firestore Collection |
|-------|---------|---------------------|
| `SQUser` | User profile | `users` |
| `SQLevel` | Game level | `levels` |
| `SQSection` | Level grouping | `sections` |
| `SQQuestion` | Quiz question | `questions` |
| `SQUserLevelData` | User progress per level | `users/{uid}/levelData` |
| `SQGameSession` | Active game state | (runtime only) |
| `SQProgress` | Progress tracking | (runtime only) |

---

## SQUser

```swift
public struct SQUser: Codable, Hashable, Identifiable {
    @DocumentID public var id: String?
    
    public var firstName: String
    public var lastName: String
    public var email: String
    public var age: Int
    
    @ServerTimestamp public var createdAt: Date?
    
    public var image: String?         // Cloudinary URL
    public var currentLevel: String?
    public var totalScore: Int
    
    public var fullName: String { "\(firstName) \(lastName)" }
}
```

---

## SQLevel

```swift
public struct SQLevel: Codable, Identifiable {
    @DocumentID public var id: String?
    public var sectionId: String
    public var name: String
    public var number: Int
    public var minScore: Int
}
```

---

## SQQuestion

```swift
public enum SQQuestionType: String, Codable {
    case selectAlphabet   // Multiple choice: select letter
    case selectGesture    // Multiple choice: select gesture image  
    case performGesture   // Camera: perform the gesture
}

public struct SQQuestion: Codable, Identifiable {
    @DocumentID public var id: String?
    public let levelId: String
    public let type: SQQuestionType
    public let content: SQQuestionContent
    public let correctAnswerIndex: Int
}

public struct SQQuestionContent: Codable {
    public let prompt: String
    public let isPromptImage: Bool
    public let answers: [SQAnswer]
    public let exampleImage: String?
}

public struct SQAnswer: Codable {
    public let value: String
    public let isImage: Bool
}
```

---

## SQUserLevelData

```swift
public enum SQUserLevelDataStatus: String, Codable {
    case locked
    case available
    case completed
}

public struct SQUserLevelData: Codable, Identifiable {
    @DocumentID public var id: String?  // levelId
    public var status: SQUserLevelDataStatus
    public var bestScore: Int
    public var lastAttempted: Date?
}
```

---

## Common Patterns

### Firestore Property Wrappers

```swift
@DocumentID var id: String?      // Auto-populated from document ID
@ServerTimestamp var date: Date? // Auto-populated on write
```

### Sendable Conformance

All models use `@unchecked Sendable` for async compatibility:

```swift
public struct SQUser: Codable, @unchecked Sendable { ... }
```

---

## Common Tasks

### Adding a New Model

1. Create `SQNewModel.swift`
2. Conform to `Codable, Identifiable, Hashable`
3. Add `@DocumentID var id: String?`
4. Add `@unchecked Sendable` for async usage
5. Create corresponding Firestore collection

### Adding a Field to Existing Model

1. Add property with default value for backward compatibility
2. Update related NetworkService queries
3. Update Firestore security rules if needed
