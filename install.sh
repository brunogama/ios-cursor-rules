#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ensure we have required commands
if ! command_exists curl; then
    echo "Error: curl is required but not installed. Please install curl first."
    exit 1
fi

# Create temporary directory
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

# GitHub raw content base URL
REPO_URL="https://raw.githubusercontent.com/zackiles/cursor-config/main"

# Download CURSOR-RULES.md
echo "Downloading CURSOR-RULES.md..."
curl -s "$REPO_URL/CURSOR-RULES.md" -o "$TMP_DIR/CURSOR-RULES.md"

# Create .cursor directory if it doesn't exist
mkdir -p .cursor/rules

# Download CURSOR-RULES.md to current directory
cp "$TMP_DIR/CURSOR-RULES.md" "./CURSOR-RULES.md"

# Download .cursorignore
echo "Downloading .cursorignore..."
curl -s "$REPO_URL/.cursorignore" -o "$TMP_DIR/.cursorignore"

# Download .cursorignore to current directory
cp "$TMP_DIR/.cursorignore" "./.cursorignore"

# Download .cursorignoreindex
echo "Downloading .cursorignoreindex..."
curl -s "$REPO_URL/.cursorignoreindex" -o "$TMP_DIR/.cursorignoreindex"

# Download .cursorignoreindex to current directory
cp "$TMP_DIR/.cursorignoreindex" "./.cursorignoreindex"

# Function to download and copy rule files
download_rule() {
    local file="$1"
    local target_path=".cursor/rules/$file"
    
    # Only download if file doesn't exist
    if [ ! -f "$target_path" ]; then
        echo "Downloading $file..."
        curl -s "$REPO_URL/.cursor/rules/$file" -o "$TMP_DIR/$file"
        cp "$TMP_DIR/$file" "$target_path"
    else
        echo "Skipping $file (already exists)"
    fi
}

# List of rule files to download
RULE_FILES=(
    "create-commit-message.mdc"
    "create-mcp-server.mdc"
    "create-prompt.mdc"
    "create-release.mdc"
    "create-tests.mdc"
    "finalize.mdc"
    "prepare.mdc"
    "propose.mdc"
    "recover.mdc"
    "with-deno.mdc"
    "with-javascript-vibe.mdc"
    "with-javascript.mdc"
    "with-mcp.mdc"
    "with-project-directory"
    "with-tests.mdc"
)

# Download each rule file
for file in "${RULE_FILES[@]}"; do
    download_rule "$file"
done

echo "Installation completed successfully!" 
