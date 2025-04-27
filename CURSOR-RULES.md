# Available Cursor @ Rules

This project contains Swift/iOS-focused Cursor rules!

The following rules are configured in `.cursor/rules` and can be triggered using the `@` command, though some activate automatically based on configuration in `RULES_FOR_AI.md` or when relevant files are added to the chat that match the rule's glob pattern.

## 1. iOS Development

Rules specifically tailored for iOS and Swift development. Activates automatically with appropriate file types or can be added manually.

| Rule | Trigger Type | Description |
|------|--------------|-------------|
| **`with-swift.mdc`** | Semi-Manual | Enforces Swift coding standards and best practices. Activates with `.swift` files, providing guidance on naming conventions, memory management, error handling, and Swift idioms. |
| **`with-ios.mdc`** | Semi-Manual | Provides iOS-specific development patterns and architectural guidance. Covers UIKit vs SwiftUI, app lifecycle, device capabilities, accessibility, and iOS data management strategies. |
| **`create-tests-swift.mdc`** | Semi-Manual | Guidelines for creating effective Swift tests using XCTest and other frameworks. Covers unit, UI, and integration testing, mocking, and testing asynchronous code. |
| **`create-ios-release.mdc`** | Semi-Manual | Comprehensive guide for iOS app deployment and release process. Covers App Store submission, TestFlight, code signing, and CI/CD with Fastlane. |

## 2. General Utilities

General purpose and frequently used rules that are helpful for any Swift/iOS project.

| Rule | Trigger Type | Description |
|------|--------------|-------------|
| **`create-release.mdc`** | Manual | Intelligently handles everything needed to release an iOS app. Handles version bumps, documentation, changelog updates, branching, tagging, etc. |
| **`finalize.mdc`** | Semi-Automatic | Ensures the AI fully completes its previous work. Outlines cleanup steps after code generation or modifications to ensure the changes made to the codebase are clean, functional, free of dead-code, and well-documented. |

## 3. Testing and Debugging

These rules are best to add at the end of your message to provide additional context in Agent mode.

| Rule | Trigger Type | Description |
|------|--------------|-------------|
| **`create-tests-swift.mdc`** | Semi-Manual | Guidelines for creating effective Swift tests, emphasizing simplicity, locality, and reusability. Activates automatically with test files. |
| **`with-tests.mdc`** | Manual | Procedures for chatting about and analyzing your tests as well as running tests. |
| **`recover.mdc`** | Manual | Steps to take when facing persistent errors. Configured to be recommended by the model when appropriate, otherwise triggers manually. |

### 3.1 Examples

Here's an entire workflow to write tests, run them, and then recover if the test writing goes wrong:

1 ) Write the tests (Agent Mode):

```text
"Add a new test to ensure graceful shutdown of the app when backgrounded. @create-tests-swift"
```

2 ) Run the tests (Agent Mode):

```text
"Great tests. Now run them and debug any errors in the output. @with-tests"
```

3 ) If issues persist (Agent Mode):

```text
"You keep introducing errors into the tests! @recover"
```

## 4. Planning and Documentation

These rules are for Chat mode only, and are best added at the end of your message to provide additional context.

| Rule | Trigger Type | Description |
|------|--------------|-------------|
| **`prepare.md`** | Manual | Prompts the model to perform thorough research and preparation before making changes to maintain code cohesiveness. |
| **`propose.md`** | Manual | Structures brainstorming sessions and question-answering without direct code changes. Results can be exported via @summary or implemented in composer mode. |
| **`create-prompt.mdc`** | Semi-Automatic | Guidelines for creating comprehensive AI prompts with clear objectives and examples. Activates when prompt generation is requested. |

### 4.1 Examples

Here's an entire workflow to plan and implement a significant change:

1 ) Plan a great proposal first, and iron out the details:

```text
"Review the Swift files I've shared and write a proposal to refactor the networking layer to be more modular. @propose @prepare"
```

2 ) Then after the proposal looks good:

```text
"Great proposal, now generate a prompt to implement it. @create-prompt"
```
