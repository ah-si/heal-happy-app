#!/usr/bin/env bash

echo "Generate app for web"
flutter clean
flutter build web --source-maps --dart-define FLUTTER_WEB_CANVASKIT_URL=/canvaskit/
APP_VERSION=$(grep version pubspec.yaml | cut -c 10-)
echo "Push sourcemaps for $APP_VERSION"
sentry-cli releases files $APP_VERSION upload-sourcemaps /build/web
rm build/web/main.dart.js.map
echo "Copy source to backend project"
cp -R build/web/ ../../ahSoignezHeureux/assets/public/
