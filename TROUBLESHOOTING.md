# 🔧 Troubleshooting Guide

## Common Issues & Solutions

### ✅ FIXED: Record Package Compilation Error

**Issue:**
```
Error: The non-abstract class 'RecordLinux' is missing implementations
```

**Solution:**
Updated `record` package from `^5.0.4` to `^5.1.2` in `pubspec.yaml`.

**Steps taken:**
1. Updated pubspec.yaml
2. Ran `flutter pub get`
3. Ran `flutter clean`

**Status:** ✅ Fixed

---

## ✅ FIXED: Font Asset Error

**Issue:**
```
Error: unable to locate asset entry in pubspec.yaml: "assets/fonts/Inter-Regular.ttf"
```

**Solution:**
Commented out the fonts section in `pubspec.yaml` until fonts are downloaded.

**Steps taken:**
1. Commented out fonts configuration in pubspec.yaml
2. Ran `flutter pub get`
3. App now uses system fonts

**To add custom fonts later:**
1. Download Inter and Outfit fonts
2. Place in `assets/fonts/` directory
3. Uncomment fonts section in pubspec.yaml
4. Run `flutter pub get`

**Status:** ✅ Fixed - App runs with system fonts

---

## Other Common Issues

### Issue: Fonts Not Showing

**Symptoms:**
- App uses system fonts instead of Inter/Outfit

**Solution:**
1. Download fonts from Google Fonts
2. Place in `assets/fonts/` directory
3. Run `flutter pub get`
4. Restart app

**See:** `assets/fonts/README.md`

---

### Issue: Build Errors After Updating Dependencies

**Solution:**
```bash
flutter clean
flutter pub get
flutter run
```

---

### Issue: Android Build Fails

**Common Causes:**
1. Gradle cache issues
2. NDK version mismatch
3. Dependency conflicts

**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

---

### Issue: iOS Build Fails

**Common Causes:**
1. CocoaPods cache
2. Xcode version
3. Signing issues

**Solution:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter run
```

---

### Issue: Hot Reload Not Working

**Solution:**
1. Stop the app
2. Run `flutter clean`
3. Restart the app

---

### Issue: Package Version Conflicts

**Symptoms:**
```
version solving failed
```

**Solution:**
1. Check `pubspec.yaml` for version constraints
2. Run `flutter pub outdated`
3. Update conflicting packages
4. Run `flutter pub get`

---

### Issue: Gradle Build Timeout

**Solution:**
Add to `android/gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx2048m -XX:MaxPermSize=512m
org.gradle.daemon=true
org.gradle.parallel=true
```

---

### Issue: Out of Memory During Build

**Solution:**
1. Close other applications
2. Increase Gradle memory (see above)
3. Build in release mode: `flutter run --release`

---

### Issue: API Keys Not Working

**Checklist:**
- [ ] API key added to `app_constants.dart`
- [ ] API key enabled in Google Cloud Console
- [ ] Billing enabled (for Google Maps)
- [ ] Correct restrictions set

---

### Issue: Location Services Not Working

**Checklist:**
- [ ] Permissions added to AndroidManifest.xml
- [ ] Permissions added to Info.plist (iOS)
- [ ] Location services enabled on device
- [ ] App has location permission

---

### Issue: Camera Not Working

**Checklist:**
- [ ] Camera permission in AndroidManifest.xml
- [ ] Camera permission in Info.plist (iOS)
- [ ] App has camera permission
- [ ] Device has working camera

---

## Build Commands Reference

### Clean Build
```bash
flutter clean
flutter pub get
flutter run
```

### Debug Build
```bash
flutter run
```

### Release Build (Android)
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### Release Build (iOS)
```bash
flutter build ios --release
```

### Analyze Code
```bash
flutter analyze
```

### Run Tests
```bash
flutter test
```

### Check Dependencies
```bash
flutter pub outdated
```

---

## Performance Issues

### App Slow to Start

**Solutions:**
1. Use release mode: `flutter run --release`
2. Optimize images
3. Lazy load data
4. Use const constructors

### High Memory Usage

**Solutions:**
1. Dispose controllers properly
2. Clear image cache
3. Use pagination
4. Profile with DevTools

### Battery Drain

**Solutions:**
1. Reduce location updates frequency
2. Optimize background tasks
3. Use efficient animations
4. Profile battery usage

---

## Development Tips

### Speed Up Development

1. **Use Hot Reload**: Press `r` in terminal
2. **Use Hot Restart**: Press `R` in terminal
3. **Skip Gradle**: Use `--no-build` flag
4. **Use Emulator**: Faster than physical device for testing

### Debug Effectively

1. **Use DevTools**: `flutter pub global activate devtools`
2. **Add Breakpoints**: In VS Code/Android Studio
3. **Use Print Statements**: For quick debugging
4. **Check Logs**: `flutter logs`

### Keep Dependencies Updated

```bash
flutter pub outdated
flutter pub upgrade
```

---

## Getting Help

### Resources
- Flutter Docs: https://flutter.dev/docs
- GetX Docs: https://pub.dev/packages/get
- Stack Overflow: https://stackoverflow.com/questions/tagged/flutter

### Project Documentation
- `README.md` - Project overview
- `QUICKSTART.md` - Getting started
- `IMPLEMENTATION_PLAN.md` - Development roadmap
- `CHECKLIST.md` - Task tracking

---

## Emergency Fixes

### Nuclear Option (When All Else Fails)

```bash
# Delete everything and start fresh
flutter clean
rm -rf pubspec.lock
rm -rf .dart_tool
rm -rf build
rm -rf ios/Pods
rm -rf ios/.symlinks
rm -rf android/.gradle

# Reinstall
flutter pub get
cd ios && pod install && cd ..
flutter run
```

### Reset Flutter

```bash
flutter doctor
flutter upgrade
flutter clean
```

---

**Last Updated: January 12, 2026**

**Status: Record package issue FIXED ✅**
