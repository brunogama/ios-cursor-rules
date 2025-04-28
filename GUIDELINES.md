# Cursor Swift Rules Guidelines

This document provides comprehensive guidelines for using and developing Swift/iOS-focused Cursor rules.

## Table of Contents
- [Introduction](#introduction)
- [Rule Categories](#rule-categories)
- [Using Rules](#using-rules)
- [Development Principles](#development-principles)
- [Best Practices](#best-practices)
- [Common Patterns](#common-patterns)
- [Troubleshooting](#troubleshooting)

## Introduction

Cursor Swift Rules is a collection of AI-powered development rules specifically designed for Swift and iOS development. These rules help maintain consistency, improve code quality, and accelerate development workflows.

### Key Features
- Automatic Swift best practices enforcement
- iOS-specific architectural patterns
- SwiftUI and UIKit integration guidance
- Testing and documentation automation
- Release and deployment assistance

## Rule Categories

### 1. Development Rules
- **`with-swift.mdc`**: Swift language best practices
- **`with-ios.mdc`**: iOS platform patterns
- **`with-swiftui.mdc`**: SwiftUI-specific patterns
- **`with-uikit.mdc`**: UIKit-specific patterns

### 2. Testing Rules
- **`create-tests-swift.mdc`**: Swift test creation
- **`with-tests.mdc`**: Test execution and analysis
- **`test-coverage.mdc`**: Coverage reporting

### 3. Release Rules
- **`create-ios-release.mdc`**: iOS app release
- **`create-release.mdc`**: General release management
- **`with-fastlane.mdc`**: Fastlane integration

### 4. Documentation Rules
- **`create-docs.mdc`**: Documentation generation
- **`with-jazzy.mdc`**: Jazzy documentation
- **`with-docc.mdc`**: DocC integration

## Using Rules

### Rule Activation

Rules can be activated in three ways:

1. **Automatic Activation**
   ```swift
   // This will automatically activate with-swift.mdc
   class MySwiftClass {
       // Your code
   }
   ```

2. **Manual Activation**
   ```text
   @with-swift
   ```

3. **File Pattern Matching**
   - `.swift` files → `with-swift.mdc`
   - `Tests/` directory → `create-tests-swift.mdc`
   - `*.xcodeproj` → `with-ios.mdc`

### Rule Composition

Combine multiple rules for comprehensive coverage:

```text
@with-swift @with-swiftui @create-tests-swift
```

## Development Principles

### 1. Swift-First Design
- Prioritize Swift idioms and patterns
- Leverage Swift's type system
- Follow Swift API design guidelines

### 2. iOS Platform Awareness
- Consider iOS lifecycle
- Handle device capabilities
- Support multiple screen sizes
- Implement proper memory management

### 3. Testing Integration
- Write testable code
- Include test coverage requirements
- Support both unit and UI testing
- Enable quick test feedback

### 4. Documentation Requirements
- Maintain clear documentation
- Include usage examples
- Document edge cases
- Provide troubleshooting guides

## Best Practices

### Rule Writing

1. **Clear Activation Conditions**
   ```mdc
   ---
   description: "Activates for SwiftUI view files"
   globs: ["*/Views/*.swift"]
   ---
   ```

2. **Specific Pattern Matching**
   ```mdc
   filters:
     - type: file_change
       pattern: "*.swift"
     - type: content
       pattern: "struct.*View"
   ```

3. **Helpful Error Messages**
   ```mdc
   action: |
     When encountering memory issues:
     1. Check for retain cycles
     2. Verify weak references
     3. Inspect closure captures
   ```

### Rule Organization

1. **Logical Grouping**
   ```
   .cursor/rules/
   ├── swift/
   │   ├── with-swift.mdc
   │   └── with-swiftui.mdc
   ├── testing/
   │   └── create-tests-swift.mdc
   └── release/
       └── create-ios-release.mdc
   ```

2. **Clear Naming**
   - Use descriptive prefixes
   - Indicate primary purpose
   - Follow naming conventions

## Common Patterns

### 1. Memory Management
```mdc
action: |
  Check for:
  - Strong reference cycles
  - Proper use of weak/unowned
  - Closure capture lists
  - Deinitialization
```

### 2. UI Patterns
```mdc
action: |
  Verify:
  - Main thread UI updates
  - Proper layout constraints
  - Accessibility support
  - Dark mode compatibility
```

### 3. Testing Patterns
```mdc
action: |
  Ensure:
  - Isolated test cases
  - Proper mock objects
  - Async test support
  - Performance testing
```

## Troubleshooting

### Common Issues

1. **Rule Not Activating**
   - Check file patterns
   - Verify rule syntax
   - Review activation conditions

2. **Conflicting Rules**
   - Check rule priorities
   - Review rule combinations
   - Adjust activation conditions

3. **Performance Issues**
   - Optimize pattern matching
   - Reduce rule complexity
   - Cache frequent operations

### Debug Process

1. Enable debug logging:
   ```mdc
   ---
   debug: true
   ---
   ```

2. Check rule activation:
   ```bash
   cursor rules status
   ```

3. Verify rule syntax:
   ```bash
   cursor rules lint
   ```

## Need Help?

- Check our [FAQ](./FAQ.md)
- Join our community discussions
- Submit an issue
- Review existing rules for examples

Remember: The goal is to enhance Swift/iOS development workflow while maintaining code quality and consistency. 