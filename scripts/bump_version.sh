#!/bin/bash

set -e

PART=$1  # patch, minor, or major

if [[ -z "$PART" ]]; then
  echo "Usage: ./bump_version.sh [patch|minor|major]"
  exit 1
fi

FILE="pyproject.toml"

# Extract current version
VERSION=$(grep -E '^version\s*=' $FILE | sed -E "s/version\s*=\s*\"([0-9]+)\.([0-9]+)\.([0-9]+)\"/\1 \2 \3/")

read -r MAJOR MINOR PATCH <<< "$VERSION"

# Bump logic
case "$PART" in
  patch)
    PATCH=$((PATCH + 1))
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  *)
    echo "Invalid bump part: $PART"
    exit 1
    ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"

# Replace version in pyproject.toml
sed -i'' -E "s/^version\s*=\s*\"[0-9]+\.[0-9]+\.[0-9]+\"/version = \"$NEW_VERSION\"/" $FILE

echo "✅ Bumped version to $NEW_VERSION"
