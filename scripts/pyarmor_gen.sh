#!/bin/bash

# === CONFIGURATION ===

# List folders to obfuscate
FOLDERS=(
  "src"
)

FILES=(
  "main.py"
)

# Base output directory
OUTPUT_BASE="dist"

# === SCRIPT ===

for folder in "${FOLDERS[@]}"; do
  if [ -d "$folder" ]; then
    echo "🔐 Obfuscating $folder"

    pyarmor gen --recursive  "$folder"
  else
    echo "⚠️ Folder not found: $folder"
  fi
done

for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "🔐 Obfuscating $file"

    pyarmor gen "$file"
  else
    echo "⚠️ File not found: $file"
  fi
done

echo "✅ All done. Check output in $OUTPUT_BASE/"
