# SignQuestCore Package

> Core business logic: managers, services, and secrets.

## Dependencies

| Package | Purpose |
|---------|---------|
| FirebaseAuth | User authentication state |
| FirebaseFirestore | User profile data |
| Cloudinary | Image upload SDK |
| SignQuestModels | `SQUser` model |

---

## Directory Structure

```
Sources/SignQuestCore/
├── Managers/
│   ├── SecretManager.swift       # Doppler secrets fetching
│   ├── UserDefaultManager.swift  # Local preferences
│   └── UserManager.swift         # Auth + Firestore user state
├── Secret/
│   └── Secret.swift              # ⚠️ GITIGNORED - Doppler token
└── Service/
    └── CloudinaryService.swift   # Profile image upload
```

---

## Managers

### UserManager

**Singleton managing authentication and user data:**

```swift
@MainActor
public class UserManager: ObservableObject {
    @Published public var authUser: FirebaseAuth.User?
    @Published public var firestoreUser: SQUser?
    @Published public var profileImageUrl: String?
}
```

**Features:**
- Firebase Auth state listener
- Real-time Firestore listener for user document
- Profile image URL updates
- Sign out / delete account

### SecretManager

Fetches Cloudinary credentials from Doppler at runtime:

```swift
class SecretManager {
    static let shared = SecretManager()
    
    func getCloudinaryConfig() async throws -> CloudinaryConfig
    func clearCache()
}
```

**Caching:** Credentials cached for 1 hour.

### UserDefaultsManager

Local preferences storage:

```swift
class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    var isOnboardingCompleted: Bool  // Tracks first-run
}
```

---

## CloudinaryService

Profile image upload to Cloudinary:

```swift
public class CloudinaryService {
    public static let shared = CloudinaryService()
    
    public func uploadProfileImage(_ image: UIImage, userId: String) async throws -> String
}
```

**Flow:**
1. Fetches Cloudinary config from `SecretManager`
2. Compresses image to JPEG (70% quality)
3. Uploads to Cloudinary with "profile_picture" preset
4. Returns secure URL

---

## Security

> [!CAUTION]
> `Secret.swift` is **gitignored** and must be created locally:

```swift
enum Secret {
    static let dopplerServiceToken = "your-doppler-token"
}
```

---

## Common Tasks

### Adding a New Manager

1. Create file in `Managers/`
2. Use `@MainActor` for UI-bound state
3. Make `ObservableObject` if needed
4. Use singleton pattern if app-wide

### Adding a New Secret

1. Add to Doppler project
2. Update `SecretManager.getCloudinaryConfig()` or create new method
3. Update `CloudinaryConfig` struct if needed

---

## Known Issues

- `SecretManager` uses `@unchecked Sendable` (potential thread safety issue)
- `CloudinaryService` uses `@unchecked Sendable`
- Tests are empty stubs
