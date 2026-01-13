# Font Installation Guide

## Required Fonts

This app uses two premium Google Fonts for a modern, professional look:

### 1. Inter (Primary Font)
- **Usage**: Body text, UI elements, buttons
- **Download**: https://fonts.google.com/specimen/Inter
- **Weights needed**: Regular (400), Medium (500), SemiBold (600), Bold (700)

### 2. Outfit (Secondary Font)
- **Usage**: Headlines, hero text, display text
- **Download**: https://fonts.google.com/specimen/Outfit
- **Weights needed**: Regular (400), Medium (500), SemiBold (600), Bold (700)

## Installation Steps

### Option 1: Download from Google Fonts (Recommended)

1. **Download Inter**:
   - Go to https://fonts.google.com/specimen/Inter
   - Click "Download family"
   - Extract the ZIP file
   - Copy these files to `assets/fonts/`:
     - `Inter-Regular.ttf`
     - `Inter-Medium.ttf`
     - `Inter-SemiBold.ttf`
     - `Inter-Bold.ttf`

2. **Download Outfit**:
   - Go to https://fonts.google.com/specimen/Outfit
   - Click "Download family"
   - Extract the ZIP file
   - Copy these files to `assets/fonts/`:
     - `Outfit-Regular.ttf`
     - `Outfit-Medium.ttf`
     - `Outfit-SemiBold.ttf`
     - `Outfit-Bold.ttf`

### Option 2: Use google_fonts Package (Alternative)

If you prefer not to download fonts manually, you can use the `google_fonts` package:

1. Add to `pubspec.yaml`:
```yaml
dependencies:
  google_fonts: ^6.1.0
```

2. Update `app_typography.dart`:
```dart
import 'package:google_fonts/google_fonts.dart';

static TextStyle get displayLarge => GoogleFonts.outfit(
  fontSize: 57,
  fontWeight: FontWeight.w700,
  // ... other properties
);
```

## Verify Installation

After adding fonts, run:
```bash
flutter pub get
flutter clean
flutter run
```

The app should now display with the custom fonts!

## Troubleshooting

**Fonts not showing?**
- Make sure font files are in `assets/fonts/` directory
- Check that `pubspec.yaml` has the correct font paths
- Run `flutter clean` and `flutter pub get`
- Restart your IDE

**File names don't match?**
- Rename the font files to match the names in `pubspec.yaml`
- Or update `pubspec.yaml` to match your file names

## Current Font Structure

```
assets/
└── fonts/
    ├── Inter-Regular.ttf
    ├── Inter-Medium.ttf
    ├── Inter-SemiBold.ttf
    ├── Inter-Bold.ttf
    ├── Outfit-Regular.ttf
    ├── Outfit-Medium.ttf
    ├── Outfit-SemiBold.ttf
    └── Outfit-Bold.ttf
```
