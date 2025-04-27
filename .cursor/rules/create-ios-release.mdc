---
description: 
globs: 
alwaysApply: false
---
# iOS App Release Process

As an AI assistant helping with iOS app releases, I should guide through the following process for successfully deploying iOS applications to the App Store.

## Versioning and Build Numbers

### Version Numbering Scheme

- Follow semantic versioning (MAJOR.MINOR.PATCH):
  - **MAJOR**: Breaking changes or significant UI redesigns
  - **MINOR**: New features with backward compatibility
  - **PATCH**: Bug fixes and minor improvements
- Update the version number in Xcode project settings (Info.plist)
- Increment build number for each submission, even for the same version

```swift
// Examining and updating Info.plist values programmatically
guard let infoPlistPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
      let infoPlist = NSDictionary(contentsOfFile: infoPlistPath) as? [String: Any] else {
    return
}

let version = infoPlist["CFBundleShortVersionString"] as? String // Version number (e.g. "1.2.3")
let build = infoPlist["CFBundleVersion"] as? String // Build number (e.g. "42")
```

### Git Tagging

- Tag each release in Git with the version number
- Use annotated tags with release notes
- Consider using a prefix like 'v' (e.g., v1.2.0)

```bash
# Create an annotated tag
git tag -a v1.2.0 -m "Version 1.2.0: Added dark mode support and fixed login issues"

# Push tags to remote
git push origin v1.2.0
```

## Code Signing and Provisioning

### Certificate Management

- Use Xcode's Automatic Code Signing when possible
- For manual signing, ensure certificates are properly installed and maintained
- Consider using cert/match tools from fastlane for team management
- Keep track of certificate expiration dates to avoid crisis

### Provisioning Profiles

- Use appropriate profile types for different distribution methods:
  - Development: For testing on developer devices
  - Ad Hoc: For internal distribution to registered devices
  - App Store: For App Store and TestFlight distribution
- Regenerate provisioning profiles when adding new devices or capabilities
- Keep profiles organized and up to date

```ruby
# Example using fastlane match to sync certificates and profiles
match(
  type: "appstore",
  app_identifier: "com.yourcompany.yourapp",
  readonly: true # Set to false to generate new certificates if needed
)
```

## Pre-Release Checklist

### App Testing

- Test on all supported device types and iOS versions
- Verify all app capabilities and features work correctly
- Check for memory leaks and performance issues
- Run UI tests to verify critical user flows
- Test offline mode and poor network connections

### Asset Verification

- Verify all app icons are included at correct sizes
- Check launch screen on different devices
- Ensure all text is localized correctly
- Verify dark/light mode UI (if applicable)
- Check app size and optimize if necessary

### Legal Requirements

- Verify privacy policy is up to date and accessible
- Include all required legal disclosures
- Add attribution for third-party components if required
- Ensure GDPR/CCPA compliance if applicable
- Complete App Store privacy labels accurately

## TestFlight Distribution

### Internal Testing

- Upload build to App Store Connect
- Add internal testers (no review required)
- Use TestFlight groups to organize testers
- Provide clear testing instructions and focus areas
- Collect and address feedback

### External Testing

- Set up external testing groups in TestFlight
- Submit for Beta App Review
- Allow up to 48 hours for review approval
- Set an appropriate beta expiration date
- Monitor crash reports and feedback

```ruby
# Using fastlane to upload a build to TestFlight
lane :beta do
  increment_build_number
  build_app(scheme: "YourAppScheme")
  upload_to_testflight(
    skip_waiting_for_build_processing: true, 
    changelog: "New features to test: dark mode and improved search"
  )
end
```

## App Store Submission

### App Store Connect Setup

- Complete all required metadata:
  - App name and subtitle
  - Keywords for search optimization
  - Description (engaging, accurate, compliant)
  - Support URL and marketing URL
  - App Store screenshots (all required device sizes)
  - Preview videos (optional but recommended)
  - App Store icon

### App Review Guidelines

- Review Apple's guidelines before submission
- Check for common rejection reasons
- Ensure your app doesn't claim to include features it doesn't have
- Verify in-app purchases are properly implemented
- Test the app using TestFlight build, not development build

### Submission Process

- Upload final build to App Store Connect
- Complete App Store information
- Set pricing and availability
- Configure app privacy details
- Select phased release if desired
- Submit for review

```ruby
# Using fastlane to submit to App Store
lane :release do
  capture_screenshots
  increment_build_number
  build_app(scheme: "YourAppScheme")
  upload_to_app_store(
    force: true, # Skip HTML report verification
    submit_for_review: true,
    automatic_release: true,
    submission_information: {
      add_id_info_uses_idfa: false,
      export_compliance_uses_encryption: false
    }
  )
end
```

## Automating Releases with CI/CD

### Setting Up Fastlane

- Create a Fastfile with lanes for different release tasks
- Define common parameters in Appfile
- Use match for certificate and profile management
- Set up environment variables for secure information

```ruby
# Example Fastfile structure
default_platform(:ios)

platform :ios do
  desc "Run tests"
  lane :test do
    scan(scheme: "YourAppScheme")
  end
  
  desc "Push a new beta build to TestFlight"
  lane :beta do
    increment_build_number
    build_app(scheme: "YourAppScheme")
    upload_to_testflight
  end
  
  desc "Push a new release build to the App Store"
  lane :release do
    increment_build_number
    build_app(scheme: "YourAppScheme")
    upload_to_app_store
  end
end
```

### CI Integration

- Configure CI service (GitHub Actions, CircleCI, Jenkins, etc.)
- Set up workflows for test, beta, and release lanes
- Store secrets and certificates securely in CI environment
- Automate post-submission notifications to the team

```yaml
# Example GitHub Actions workflow
name: iOS Release
on:
  push:
    branches: [ release ]
    
jobs:
  deploy:
    runs-on: macos-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 2.7
    
    - name: Install dependencies
      run: bundle install
      
    - name: Deploy to App Store
      env:
        APP_STORE_CONNECT_API_KEY_KEY_ID: ${{ secrets.APP_STORE_CONNECT_API_KEY_KEY_ID }}
        APP_STORE_CONNECT_API_KEY_ISSUER_ID: ${{ secrets.APP_STORE_CONNECT_API_KEY_ISSUER_ID }}
        APP_STORE_CONNECT_API_KEY_KEY: ${{ secrets.APP_STORE_CONNECT_API_KEY_KEY }}
        MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
      run: bundle exec fastlane release
```

## Post-Release Activities

### App Store Monitoring

- Monitor app status in App Store Connect
- Track app analytics and conversion rates
- Watch for crash reports and user feedback
- Monitor competing apps and industry trends
- Set up App Store Connect API access for automated monitoring

### User Feedback and Ratings

- Respond to App Store reviews
- Track user-reported issues
- Prioritize critical bug fixes for next release
- Consider implementing in-app feedback mechanisms
- Use ratings prompts at appropriate moments in the user journey

```swift
// Example of requesting a review at appropriate time
if shouldRequestReview() {
    if #available(iOS 14.0, *) {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    } else {
        SKStoreReviewController.requestReview()
    }
}
```

### Planning the Next Release

- Start roadmap planning for the next version
- Prioritize bug fixes vs new features
- Consider App Store feature request timing
- Schedule regular update cycles
- Communicate timeline to stakeholders

## App Store Optimization (ASO)

### Keywords and Metadata

- Research and choose relevant keywords
- Optimize app name and subtitle
- Write compelling descriptions
- Update screenshots for seasonal events if relevant
- Consider localizing for important markets

### Continuous Improvement

- Analyze competitor apps regularly
- Run A/B tests on app screenshots and descriptions where possible
- Update keywords based on performance data
- Refresh screenshots for major iOS releases
- Track keyword rankings and adjust strategy

## Release Strategies

### Phased Release

- Use phased releases for major updates to catch issues early
- Start with a small percentage (1-5%) of users
- Monitor crash rates before expanding
- Proceed with full rollout if metrics are stable
- Have a rollback plan ready if problems occur

### Feature Flags

- Implement feature flags for gradual feature rollout
- Test new features with a limited audience
- Use remote configuration to enable/disable features
- Prepare contingency plans for feature removal
- Document feature flag status for each release

```swift
// Example of a simple feature flag system
class FeatureFlags {
    static let shared = FeatureFlags()
    
    private let defaults = UserDefaults.standard
    private let remoteConfig: RemoteConfigService
    
    init(remoteConfig: RemoteConfigService = RemoteConfigService.shared) {
        self.remoteConfig = remoteConfig
    }
    
    func isEnabled(_ feature: Feature) -> Bool {
        // Check remote config first
        if let remoteValue = remoteConfig.getBool(forKey: feature.rawValue) {
            return remoteValue
        }
        
        // Fall back to default values
        return feature.defaultValue
    }
    
    enum Feature: String {
        case newSearchUI = "feature_new_search_ui"
        case darkMode = "feature_dark_mode"
        
        var defaultValue: Bool {
            switch self {
            case .newSearchUI: return false
            case .darkMode: return true
            }
        }
    }
}
```

## Common Release Pitfalls to Avoid

### Technical Issues

- Forgetting to update privacy labels when adding features
- Accidentally submitting debug build instead of release
- Not testing with production API endpoints
- Missing entitlements or capabilities configuration
- Expired certificates or provisioning profiles

### Process Issues

- Not allowing enough time for app review
- Failing to test in-app purchases in sandbox environment
- Insufficient testing on older devices or iOS versions
- Skipping TestFlight external testing
- Missing App Store requirements like privacy policy

### Communication Issues

- Inadequate release notes
- Poor timing (e.g., submitting right before holidays)
- Not communicating release dates to stakeholders
- Mismanaged customer expectations for new features
- Failure to warn users about major changes

Remember that the App Store release process requires careful planning and execution. A systematic approach with proper automation can save time and reduce stress for the entire development team.
