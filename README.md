# **Swift/iOS Cursor Rules**

An opinionated suite of [Cursor Rules](https://docs.cursor.com/context/rules-for-ai) specifically tailored for iOS and Swift development. These rules provide AI guidance for Swift programming, iOS app architecture, testing, and App Store deployment.

> [!NOTE]  
> Checkout [How Cursor Rules Work](how-cursor-rules-work.md) for an undocumented deep-dive on how Cursor uses them internally.

## **How To Use These Rules**

Run the following command in the root of your iOS project to install these rules:

```bash
curl -fsSL https://raw.githubusercontent.com/zackiles/cursor-config/main/install.sh | bash
```

That's it! The rules will be automatically detected by Cursor and the [documentation for the rules](CURSOR-RULES.md) will be written to your project root for reference. If you ever want to update the rules, simply run the install script again.

## Available Rules

**These iOS-specific rules are available**:

- `with-swift`: Swift coding standards and best practices
- `with-ios`: iOS development patterns and architecture
- `create-tests-swift`: Swift and iOS testing best practices
- `create-ios-release`: iOS app release and deployment workflows
- `finalize`: Ensures the AI completes tasks fully and properly
- `prepare`: Research and preparation for complex changes 
- `propose`: Structured brainstorming without direct code changes
- `recover`: Steps to recover from persistent errors

> [!NOTE]  
> For full documentation and examples for each rule, see [CURSOR-RULES.md](CURSOR-RULES.md).

## Using iOS Rules

### with-swift

This rule activates when editing `.swift` files and provides detailed guidance on Swift coding standards, including:
- Naming conventions and code organization
- Swift idioms and best practices
- Memory management guidelines
- Error handling patterns
- Usage of modern Swift features

Add to your prompt: `@with-swift` or open any Swift file.

### with-ios

This rule covers iOS-specific development patterns and architectural considerations:
- App architecture recommendations (MVC, MVVM, etc.)
- UIKit vs SwiftUI guidance
- iOS app lifecycle management
- Device capabilities and constraints
- Accessibility implementation
- Data management strategies

Add to your prompt: `@with-ios` or open iOS project files.

### create-tests-swift

This rule provides in-depth guidance for testing iOS applications:
- XCTest framework usage
- Unit, UI, and integration testing
- Mocking and stubbing in Swift
- Testing asynchronous code
- Core Data testing strategies
- Quick/Nimble BDD testing

Add to your prompt: `@create-tests-swift` or open test files.

### create-ios-release

This rule guides through the iOS app release process:
- App Store submission workflow
- Code signing and provisioning
- TestFlight distribution
- CI/CD setup with Fastlane
- App Store optimization
- Post-release monitoring

Add to your prompt: `@create-ios-release` or open release configuration files.

## Swift Best Practices

Following Swift best practices is essential for writing maintainable, efficient code. As outlined by Kalidoss Shanmugam in "[Best vs. Worst Coding Practices in Swift](https://medium.com/@kalidoss.shanmugam/best-vs-worst-coding-practices-in-swift-20-key-examples-e70ca2c2a0f3)", pay attention to:

1. **Consistent naming conventions**: Use clear, descriptive names following Swift's guidelines
2. **Safe handling of optionals**: Avoid force unwrapping with `!` and use `if let` or `guard let` instead
3. **Using `guard` statements** for early exits to improve code readability
4. **Protocol-oriented programming**: Favor protocol composition over inheritance
5. **Memory management**: Use `[weak self]` in closures to avoid retain cycles
6. **Swift's modern features**: Embrace Swift idioms like map/filter/reduce

## Editing Rules

Rules are written in [MDC Syntax](https://github.com/nuxt-modules/mdc) and can be edited in a regular text editor or within Cursor for an enhanced MDC editing experience. They're stored in `./cursor/rules/*.mdc`.

Read more on [Cursor's Documentation](https://docs.cursor.com/context/rules-for-ai) or check out community-contributed rules on the [cursor.directory](https://cursor.directory/).

## Manual vs Automatic Rules

Rules in `.cursor/rules` will either:  

- **Have a glob specified** and run automatically when the glob is detected for a file in the context window
- **Have no glob specified**, in which case the rule only runs when triggered manually using the [@ command](https://docs.cursor.com/context/@-symbols/basic)

## Other Configurations

### Cursor Global Prompt (Optional)

The file [CURSOR-GLOBAL-PROMPT.md](CURSOR-GLOBAL-PROMPT.md) can be copied directly into the `User Rules` box in `Cursor Settings -> Rules`. This acts as the global prompt applied to all interactions with the agent. It's optimized to work with the provided rules but is optional.

### .cursorignore & .cursorindexignore

Example `.cursorignore` and `.cursorignoreindex` files are provided to control what files Cursor indexes or ignores. This prevents cluttering Cursor's context window with unnecessary files and avoids confusing the AI with outdated documentation.

#### Differences

**.cursorignore:** For completely ignoring files in cursor. Things in `.gitignore` are already automatically ignored.

**.cursorignoreindex:** For files you want available only when manually provided. These files are NOT indexed. Useful for large schema files or documentation you only want to reference explicitly.

## TODO

- Add sample Xcode project templates
- Create SwiftUI-specific rule examples
- Add common iOS design patterns documentation
- Expand accessibility guidelines for iOS apps
- Create AI docs for Swift using Cursor's `@doc` system. See [Cursor @Docs](https://docs.cursor.com/context/@-symbols/@-docs).
# my-ios-opinionated-cursor-rules
