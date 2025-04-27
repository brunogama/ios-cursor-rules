---
description: 
globs: 
alwaysApply: false
---
# iOS Development Best Practices

As an AI assistant working on iOS applications, I should follow these guidelines to ensure high-quality, user-friendly, and efficient iOS apps.

## iOS App Architecture

### Architecture Patterns

- Use appropriate architecture patterns based on app complexity:
  - **MVC**: Simple apps or when following Apple's basic patterns
  - **MVVM**: Medium complexity apps, works well with SwiftUI/Combine
  - **VIPER/Clean**: Complex apps requiring clear separation of concerns
  - **Composable Architecture**: Advanced reactive apps with predictable state management

- Keep view controllers/views lightweight by moving business logic to separate components
- Use coordinator pattern for complex navigation flows
- Consider feature-based modularization for large applications

### Project Organization

- Organize project by feature, not by type
- Use Swift packages to modularize components
- Group related files in logical folders
- Utilize Xcode's project navigator groups to maintain code organization

```
AppProject/
├── Core/
│   ├── Networking/
│   ├── Storage/
│   ├── Authentication/
│   └── Common UI Components/
├── Features/
│   ├── User Profile/
│   │   ├── Models/
│   │   ├── Views/
│   │   └── ViewModels/
│   ├── Shopping Cart/
│   │   ├── Models/
│   │   ├── Views/
│   │   └── ViewModels/
├── Resources/
│   ├── Assets.xcassets/
│   ├── Localization/
│   └── Fonts/
└── Supporting Files/
    ├── AppDelegate.swift
    ├── SceneDelegate.swift
    ├── Info.plist
    └── Configuration/
```

## UIKit vs SwiftUI

### When to Use UIKit
- When targeting iOS 12 or earlier
- For complex custom UI that's difficult to implement in SwiftUI
- When you need precise control over UI performance optimization
- For apps heavily dependent on UIKit-specific features

### When to Use SwiftUI
- For new apps targeting iOS 14+
- For rapid development and prototyping
- When you want to share UI code across Apple platforms
- For list-based interfaces and standard UI components

### Hybrid Approach
- Consider UIHostingController to embed SwiftUI views in UIKit apps
- Use UIViewRepresentable and UIViewControllerRepresentable to embed UIKit in SwiftUI
- Adopt SwiftUI for new features while maintaining existing UIKit code

```swift
// UIKit hosting SwiftUI example
let profileView = ProfileView(user: currentUser)
let hostingController = UIHostingController(rootView: profileView)
navigationController.pushViewController(hostingController, animated: true)

// SwiftUI hosting UIKit example
struct MapViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the map view
    }
}
```

## iOS App Lifecycle Management

### Modern App Lifecycle (iOS 13+)
- Use SceneDelegate for apps supporting multiple windows
- Properly handle state transitions in `sceneWillResignActive`, `sceneDidEnterBackground`, etc.
- Save user data during state transitions

### Legacy App Lifecycle
- For iOS 12 and earlier, use AppDelegate for lifecycle events
- Handle all state transitions appropriately: `applicationWillResignActive`, `applicationDidEnterBackground`, etc.

### Background Tasks
- Register background tasks with identifiers in your app delegate
- Keep background execution code efficient to avoid system termination
- Use appropriate background modes in Info.plist
- Consider using BGAppRefreshTask for periodic updates

```swift
// Registering a background task
var backgroundTask: UIBackgroundTaskIdentifier = .invalid

func startBackgroundTask() {
    backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
        self?.endBackgroundTask()
    }
    
    // Perform background work
    
    endBackgroundTask()
}

func endBackgroundTask() {
    if backgroundTask != .invalid {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}
```

## Handling Device Capabilities and Constraints

### Device Adaptation
- Use Auto Layout for responsive UI across different screen sizes
- Implement size classes to adapt layouts between iPhone and iPad
- Use Dynamic Type to support different text sizes
- Test on multiple device sizes and orientations

### Resource Management
- Optimize images and assets for different screen scales (@1x, @2x, @3x)
- Use SF Symbols where possible instead of custom icons
- Monitor and optimize memory usage, especially on older devices
- Implement appropriate caching strategies for network resources

### Performance
- Use Instruments to profile app performance (CPU, memory, energy usage)
- Ensure smooth scrolling in table/collection views with cell reuse
- Move heavy processing to background queues
- Implement pagination for large data sets

```swift
// Example of dispatching work to background queue
DispatchQueue.global(qos: .userInitiated).async {
    // Perform expensive operation
    let processedData = self.processLargeDataSet()
    
    DispatchQueue.main.async {
        // Update UI with results
        self.updateUI(with: processedData)
    }
}
```

## Accessibility

### General Guidelines
- Make all apps fully accessible from the start of development
- Test with VoiceOver, Dynamic Type, and other accessibility features
- Support Dark Mode for better visibility
- Implement proper keyboard navigation

### VoiceOver
- Set accessibility labels, hints, and traits for all UI elements
- Group related elements with accessibility containers
- Ensure a logical reading order
- Use proper accessibility announcements for dynamic content changes

```swift
// Setting accessibility properties
button.isAccessibilityElement = true
button.accessibilityLabel = "Submit form"
button.accessibilityHint = "Double tap to submit your information"
button.accessibilityTraits = .button

// Announcing changes
UIAccessibility.post(notification: .announcement, argument: "Data successfully saved")
```

### Dynamic Type
- Use system fonts or Dynamic Type compatible custom fonts
- Test with all accessibility text sizes
- Use leading and trailing constraints instead of left/right for RTL language support

## Data Management

### Persistence
- Use appropriate storage solutions based on data complexity:
  - UserDefaults for simple key-value pairs
  - Keychain for sensitive data
  - Core Data for complex object relationships
  - CloudKit for syncing across devices
  - FileManager for file-based storage

- Always consider data privacy and security implications
- Implement proper migration strategies for data model changes

### Networking
- Use URLSession for network requests or a well-maintained library
- Implement proper error handling and retry logic
- Use Codable for JSON parsing
- Handle poor network conditions gracefully
- Cache network responses when appropriate

```swift
// Modern networking with async/await (iOS 15+)
func fetchUsers() async throws -> [User] {
    guard let url = URL(string: "https://api.example.com/users") else {
        throw NetworkError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }
    
    return try JSONDecoder().decode([User].self, from: data)
}

// Usage
Task {
    do {
        let users = try await fetchUsers()
        updateUI(with: users)
    } catch {
        handleError(error)
    }
}
```

## App Store Guidelines and Submission

### App Store Requirements
- Follow Human Interface Guidelines (HIG)
- Ensure compliance with App Store Review Guidelines
- Include required privacy labels and descriptions
- Add App Tracking Transparency (ATT) prompt if needed
- Provide complete and accurate metadata

### Submission Preparation
- Test app thoroughly on all supported devices
- Create compelling screenshots and app preview videos
- Write clear and concise app descriptions
- Use appropriate keywords for better discoverability
- Set up App Store Connect properly with all required information

### TestFlight
- Use TestFlight for beta testing before submission
- Test with both internal and external testers
- Collect and address feedback before App Store submission
- Include clear testing instructions for beta testers

## iOS-Specific Features

### Integration with Apple Ecosystem
- Implement Sign in with Apple when offering social logins
- Add appropriate iOS app extensions (Share, Today, etc.)
- Support Handoff and Continuity features for cross-device experience
- Consider implementing widgets and App Clips for better engagement

### Notifications
- Request notification permissions at appropriate times
- Implement rich notifications with images and actions
- Use notification categories for actionable notifications
- Support notification grouping for better organization

```swift
// Request notification authorization
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
    if granted {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

// Configure notification categories
let acceptAction = UNNotificationAction(
    identifier: "ACCEPT_ACTION",
    title: "Accept",
    options: .foreground
)

let declineAction = UNNotificationAction(
    identifier: "DECLINE_ACTION",
    title: "Decline",
    options: .destructive
)

let category = UNNotificationCategory(
    identifier: "INVITATION_CATEGORY",
    actions: [acceptAction, declineAction],
    intentIdentifiers: [],
    options: []
)

UNUserNotificationCenter.current().setNotificationCategories([category])
```

### Deep Linking
- Implement Universal Links for web-to-app transitions
- Set up custom URL schemes for app-to-app communication
- Handle all deep links appropriately to direct users to the right content
- Support Spotlight search indexing for in-app content

## Common iOS Patterns

### Delegation
- Use delegation for one-to-one callbacks
- Define clear protocol interfaces with @objc if needed for Objective-C compatibility
- Consider using closures for simpler callback scenarios

### Closures and Completion Handlers
- Use closures for asynchronous callbacks
- Always consider memory management ([weak self])
- Use Result type for operations that can succeed or fail

### Combine/Reactive Patterns
- Use Combine for reactive data streams when targeting iOS 13+
- Implement publishers for data that changes over time
- Use appropriate operators to transform data streams
- Always handle subscription lifecycle to avoid memory leaks

```swift
// Combine example
cancellables = Set<AnyCancellable>()

searchTextField.textPublisher
    .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
    .removeDuplicates()
    .filter { !$0.isEmpty }
    .flatMap { [weak self] searchTerm -> AnyPublisher<[SearchResult], Never> in
        guard let self = self else { return Just([]).eraseToAnyPublisher() }
        return self.performSearch(for: searchTerm)
    }
    .receive(on: RunLoop.main)
    .sink { [weak self] results in
        self?.updateSearchResults(results)
    }
    .store(in: &cancellables)
```

Remember that these best practices may evolve as Apple introduces new iOS versions and frameworks. Always refer to Apple's latest documentation and sample code for the most current recommendations.
