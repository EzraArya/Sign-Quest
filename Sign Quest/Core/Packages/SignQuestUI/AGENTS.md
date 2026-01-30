# SignQuestUI Package

> Shared UI components, colors, fonts, and utilities.

## Dependencies

- SwiftUI only (no external dependencies)

---

## Directory Structure

```
Sources/SignQuestUI/
├── Asset/
│   ├── Color/SQColor.swift       # Color palette
│   └── Fonts/SQFont.swift        # Typography
├── Components/                    # Reusable UI components
├── Extension/                     # SwiftUI extensions
├── Modifier/                      # View modifiers
├── Shape/                         # Custom shapes
└── Utils/                         # Validation, text field helpers
```

---

## Colors (SQColor)

```swift
public enum SQColor {
    case primary        // Main brand color
    case secondary      // Secondary actions
    case accent         // Highlights
    case background     // App background
    case text           // Primary text
    case muted          // Disabled/secondary text
    case error          // Error states
    case line           // Borders/dividers
    case complementary  // Accent complement
    case cream, red     // Specific colors
    
    var color: Color { ... }
}
```

---

## Fonts (SQFont)

```swift
public enum SQFont {
    case regular
    case bold
    case semibold
    case medium
    
    func font(size: CGFloat) -> Font
}
```

---

## Components

| Component | Purpose |
|-----------|---------|
| `SQButton` | Primary button with styles (default, secondary, danger, etc.) |
| `SQTextField` | Styled text input |
| `SQLabelTextField` | Text field with label |
| `SQText` | Styled text component |
| `SQImage` | Async image with placeholder |
| `SQProgressBar` | Game progress indicator |
| `SQLevelButton` | Level selection button |
| `SQAnswerButton` | Answer submission with correct/incorrect states |
| `SQAnswerGridView` | Grid of answer options |
| `SQBanner` | Banner/header component |
| `SQAlert` | Custom alert dialog |
| `SQChatBubblePopup` | Speech bubble popup |
| `SQSeperator` | Visual divider |
| `SQImageTextBox` | Image with text overlay |

---

## Button Styles

```swift
public enum SQButtonStyle {
    case `default`   // Primary action
    case secondary   // Secondary action
    case muted       // Disabled appearance
    case danger      // Destructive action
    case incorrect   // Wrong answer
    case locked      // Unavailable
}
```

---

## Modifiers

| Modifier | Purpose |
|----------|---------|
| `SQBackgroundModifier` | Apply app background |
| `SQBoxShadowModifier` | Consistent shadow style |
| `SQTextFieldModifier` | Text field styling |

**Usage:**

```swift
view.applyBackground()  // Extension method
```

---

## Extensions

### View+Extension

```swift
extension View {
    func applyBackground() -> some View
}
```

### UIImage+Extension

```swift
extension UIImage {
    static func createSolidImage(color: UIColor, size: CGSize) -> UIImage?
}
```

---

## Utils

| Utility | Purpose |
|---------|---------|
| `SQTextFieldUtil` | Text field style helpers |
| `SQValidationUtil` | Input validation |

---

## Common Tasks

### Adding a New Component

1. Create file in `Components/`
2. Make `public struct` conforming to `View`
3. Use `SQColor` and `SQFont` for consistency
4. Add `public init()` with parameters

### Adding a New Color

1. Add case to `SQColor` enum
2. Add color value in `color` computed property
3. Consider adding to asset catalog for dark mode

### Creating a Custom Modifier

1. Create in `Modifier/`
2. Conform to `ViewModifier`
3. Add convenience extension on `View`

---

## Example Usage

```swift
import SignQuestUI

struct MyView: View {
    var body: some View {
        VStack {
            SQText(text: "Hello", font: .bold, color: .text, size: 24)
            
            SQButton(
                text: "Continue",
                font: .semibold,
                style: .default,
                size: 16
            ) {
                // action
            }
        }
        .applyBackground()
    }
}
```
