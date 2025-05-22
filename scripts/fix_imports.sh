#!/bin/bash

echo "🔧 Updating import paths to include 'lib/src/'..."

# Update all Dart files: change src/... to lib/src/...
find . -type f -name "*.dart" -exec sed -i '' 's|import '\''package:lovegpt_mobileapp/src/|import '\''package:lovegpt_mobileapp/lib/src/|g' {} +

# Update pubspec.yaml for assets and fonts
sed -i '' 's|src/assets/|lib/src/assets/|g' pubspec.yaml
sed -i '' 's|src/assets/fonts/|lib/src/assets/fonts/|g' pubspec.yaml

echo "✅ Done! All imports and asset paths updated."
