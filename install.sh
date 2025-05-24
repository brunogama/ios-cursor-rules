#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for required dependencies
check_dependencies() {
    local missing_deps=()

    if ! command_exists curl; then
        missing_deps+=("curl")
    fi

    if ! command_exists xcodebuild; then
        missing_deps+=("Xcode Command Line Tools")
    fi

    if ! command_exists swift; then
        missing_deps+=("Swift")
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "Error: The following required dependencies are missing:"
        printf '%s\n' "${missing_deps[@]}"
        echo "Please install the missing dependencies and try again."
        exit 1
    fi
}

# Validate Xcode installation
validate_xcode() {
    if ! xcode-select -p &> /dev/null; then
        echo "Error: Xcode Command Line Tools are not installed."
        echo "Install them by running: xcode-select --install"
        exit 1
    fi

    # Check Xcode version
    local xcode_version=$(xcodebuild -version | head -n1 | awk '{print $2}')
    if [ -z "$xcode_version" ]; then
        echo "Error: Could not determine Xcode version."
        exit 1
    fi

    echo "Found Xcode version: $xcode_version"
}

# Create temporary directory
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

# GitHub raw content base URL
REPO_URL="https://raw.githubusercontent.com/brunogama/ios-cursor-rules/main"

# Run initial checks
echo "Checking dependencies..."
check_dependencies
echo "Validating Xcode installation..."
validate_xcode

# Create .cursor directory if it doesn't exist
mkdir -p .cursor/rules

# Download and copy configuration files
echo "Downloading configuration files..."
for config_file in "CURSOR-RULES.md" ".cursorignore" ".cursorignoreindex"; do
    if [ ! -f "./$config_file" ]; then
        echo "Downloading $config_file..."
        curl -s "$REPO_URL/$config_file" -o "$TMP_DIR/$config_file"
        cp "$TMP_DIR/$config_file" "./$config_file"
    else
        echo "Skipping $config_file (already exists)"
    fi
done

# Function to download and copy rule files
download_rule() {
    local file="$1"
    local target_path=".cursor/rules/$file"

    if [ ! -f "$target_path" ]; then
        echo "Downloading $file..."
        curl -s "$REPO_URL/.cursor/rules/$file" -o "$TMP_DIR/$file"
        if [ $? -eq 0 ]; then
            cp "$TMP_DIR/$file" "$target_path"
            echo "✓ Successfully downloaded $file"
        else
            echo "✗ Failed to download $file"
            return 1
        fi
    else
        echo "Skipping $file (already exists)"
    fi
}

# List of Swift/iOS specific rule files
RULE_FILES=(
    "with-swift.mdc"
    "with-ios.mdc"
    "create-tests-swift.mdc"
    "create-ios-release.mdc"
    "create-release.mdc"
    "finalize.mdc"
    "create-prompt.mdc"
    "prepare.mdc"
    "propose.mdc"
    "recover.mdc"
    "with-tests.mdc"
    "command-rules.mdc"
    "knowledge-management-rule.mdc"
    "location-rule.mdc"
    "on-load-rule.mdc"
    "project-onboarding-rule.mdc"
    "specification-management-rule.mdc"
    "visualization-rule.mdc"
)

# Download each rule file
echo "Downloading rule files..."
failed_downloads=0
for file in "${RULE_FILES[@]}"; do
    if ! download_rule "$file"; then
        ((failed_downloads++))
    fi
done

# Final status report
echo
echo "Installation Summary:"
echo "===================="
echo "Total rules attempted: ${#RULE_FILES[@]}"
echo "Successfully installed: $((${#RULE_FILES[@]} - failed_downloads))"
if [ $failed_downloads -gt 0 ]; then
    echo "Failed downloads: $failed_downloads"
    echo "Please check your internet connection and try again for failed downloads."
    exit 1
else
    echo "✓ All rules installed successfully!"
fi

# Create initial project structure
echo
echo "Setting up project structure..."
mkdir -p .cursor/{specs,tasks,learnings,docs,output}

echo
echo "Installation completed successfully!"
echo "You can now use Cursor with Swift/iOS specific rules."
echo "See CURSOR-RULES.md for available commands and usage."
