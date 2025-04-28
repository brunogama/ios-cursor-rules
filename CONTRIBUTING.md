# Contributing to Cursor Swift Rules

Thank you for your interest in contributing to the Cursor Swift Rules project! This document outlines the process and guidelines for contributing.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Rule Development Guidelines](#rule-development-guidelines)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)

## Code of Conduct

We are committed to providing a welcoming and inclusive experience for everyone. We expect all participants to adhere to our Code of Conduct.

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/cursor-swift-rules.git
   ```
3. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## How to Contribute

There are several ways to contribute:

1. **Add New Rules**: Create new `.mdc` files in `.cursor/rules/` for common Swift/iOS development patterns
2. **Improve Existing Rules**: Enhance existing rules with better patterns or more comprehensive coverage
3. **Documentation**: Improve documentation, examples, or add tutorials
4. **Bug Reports**: Submit issues for bugs you encounter
5. **Feature Requests**: Suggest new features or improvements

## Rule Development Guidelines

### Rule Structure
```mdc
---
description: Clear description of when the rule should be applied
globs: ["*.swift", "*.h", "*.m"]
alwaysApply: false
---

# Rule Title

<rule>
name: rule_name
filters:
  - type: file_change
    pattern: "*.swift"

actions:
  - type: react
    conditions:
      - pattern: "specific_pattern"
    action: |
      # Action description
      Detailed action steps...
</rule>
```

### Best Practices

1. **Clear Description**: Write clear descriptions that help the AI understand when to apply the rule
2. **Specific Globs**: Use specific glob patterns to target relevant files
3. **Focused Purpose**: Each rule should have a single, clear purpose
4. **Comprehensive Examples**: Include multiple examples showing different use cases
5. **Error Handling**: Include guidance for common error cases
6. **Testing**: Test rules with various scenarios before submitting

## Pull Request Process

1. **Create Issue First**: For significant changes, create an issue for discussion
2. **Branch Naming**:
   - `feature/` for new features
   - `fix/` for bug fixes
   - `docs/` for documentation changes
   - `rule/` for new or updated rules

3. **Commit Messages**: Follow conventional commits:
   ```
   feat(rule): add new SwiftUI layout rule
   fix(docs): correct typo in iOS deployment guide
   docs(readme): update installation instructions
   ```

4. **PR Description**:
   - Clear description of changes
   - Reference related issues
   - Include before/after examples if applicable
   - List any breaking changes

5. **Review Process**:
   - PRs require at least one review
   - All comments must be resolved
   - CI checks must pass

## Style Guidelines

### Rule Naming
- Use descriptive names: `with-swiftui.mdc`, `create-tests-swift.mdc`
- Use kebab-case for file names
- Include the target framework/tool in the name when specific

### Documentation
- Use clear, concise language
- Include code examples
- Document all parameters and options
- Explain when and why to use the rule

### Code Style
- Follow Swift style guidelines
- Use consistent indentation (2 spaces)
- Add comments for complex logic
- Use meaningful variable names

## Questions?

If you have questions about contributing, please:
1. Check existing issues
2. Create a new issue with the `question` label
3. Join our community discussions

Thank you for contributing to Cursor Swift Rules! 