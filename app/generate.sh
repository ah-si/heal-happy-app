#!/usr/bin/env bash

echo "Generate app for web"
flutter clean
flutter build web --source-maps --dart-define FLUTTER_WEB_CANVASKIT_URL=/canvaskit/
APP_VERSION=$(grep version pubspec.yaml | cut -c 10-)
echo "Push sourcemaps for $APP_VERSION"
sentry-cli releases files "$APP_VERSION" upload-sourcemaps build/web
rm -R build/web/canvaskit/profiling
echo "Copy sources to backend project"
cp -R build/web/ ../../heal-happy-server/assets/public/
