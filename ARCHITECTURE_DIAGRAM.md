# 🗺️ Voyage AI - App Flow & Architecture Diagram

## 📱 User Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         APP LAUNCH                               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      SPLASH SCREEN                               │
│  • Animated logo                                                 │
│  • Gradient background                                           │
│  • Loading indicator                                             │
│  • 3 second duration                                             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    ONBOARDING (3 Pages)                          │
│  Page 1: Capture Your Journey                                   │
│  Page 2: AI-Powered Storytelling                                │
│  Page 3: Organize Effortlessly                                  │
│  • Smooth page transitions                                       │
│  • Skip button                                                   │
│  • Page indicators                                               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                       LOGIN SCREEN                               │
│  • Email input                                                   │
│  • Password input                                                │
│  • Sign in button                                                │
│  • Skip for now (dev mode)                                       │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      HOME DASHBOARD                              │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  Top Bar: App Name + Notifications                       │   │
│  ├─────────────────────────────────────────────────────────┤   │
│  │  Quick Actions (Gradient Cards)                          │   │
│  │  • Voice Note                                             │   │
│  │  • Add Photo                                              │   │
│  │  • Expense                                                │   │
│  ├─────────────────────────────────────────────────────────┤   │
│  │  Recent Trips                                             │   │
│  │  • Trip cards with images                                 │   │
│  │  • Empty state if no trips                                │   │
│  ├─────────────────────────────────────────────────────────┤   │
│  │  Bottom Navigation (5 tabs)                               │   │
│  │  [Home] [Trips] [Journal] [Expenses] [Profile]           │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
       │           │           │            │            │
       ▼           ▼           ▼            ▼            ▼
    [Home]     [Trips]    [Journal]   [Expenses]   [Profile]
```

## 🏗️ Architecture Layers

```
┌──────────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                            │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Screens (UI)                                              │  │
│  │  • Splash, Onboarding, Login                               │  │
│  │  • Home, Trips, Journal, Expenses, Profile                 │  │
│  └────────────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Controllers (GetX)                                        │  │
│  │  • State management                                        │  │
│  │  • Business logic coordination                             │  │
│  └────────────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Widgets (Reusable Components)                             │  │
│  │  • Glass cards, buttons, inputs                            │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌──────────────────────────────────────────────────────────────────┐
│                      DOMAIN LAYER                                 │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Entities (Business Objects)                               │  │
│  │  • User, Trip, JournalEntry, Expense, Media                │  │
│  └────────────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Use Cases (Business Logic)                                │  │
│  │  • Create trip, Process voice, Add expense                 │  │
│  └────────────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Repository Interfaces                                     │  │
│  │  • Contracts for data operations                           │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌──────────────────────────────────────────────────────────────────┐
│                       DATA LAYER                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Models (JSON Serializable)                                │  │
│  │  • Data transfer objects                                   │  │
│  └────────────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Repository Implementations                                │  │
│  │  • Data operation logic                                    │  │
│  └────────────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Services                                                  │  │
│  │  • Network (Dio/Retrofit)                                  │  │
│  │  • Storage (Hive/SQLite)                                   │  │
│  │  • Location (Geolocator)                                   │  │
│  │  • Media (Camera/Gallery)                                  │  │
│  │  • AI (Gemini/Speech)                                      │  │
│  └────────────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Data Sources                                              │  │
│  │  • Local (Hive, SQLite, SharedPrefs)                       │  │
│  │  • Remote (REST API)                                       │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌──────────────────────────────────────────────────────────────────┐
│                      CORE LAYER                                   │
│  • Theme (Colors, Typography, Theme)                              │
│  • Constants (App-wide configuration)                             │
│  • Base Classes (BaseController)                                  │
│  • Utilities (Helpers, Extensions)                                │
│  • Error Handling (Exceptions)                                    │
└──────────────────────────────────────────────────────────────────┘
```

## 🔄 Data Flow

```
User Action (UI)
      │
      ▼
Controller (GetX)
      │
      ▼
Use Case (Business Logic)
      │
      ▼
Repository Interface
      │
      ▼
Repository Implementation
      │
      ├──────────────┬──────────────┐
      ▼              ▼              ▼
Local Storage   Remote API    External Service
 (Hive/SQLite)  (Dio/Retrofit) (Location/AI/Media)
      │              │              │
      └──────────────┴──────────────┘
                     │
                     ▼
              Data Models
                     │
                     ▼
              Domain Entities
                     │
                     ▼
              Controller (State Update)
                     │
                     ▼
              UI Update (Obx)
```

## 🎯 Feature Modules

```
┌─────────────────────────────────────────────────────────────────┐
│                      TRIP MODULE                                 │
│  • Create/Edit/Delete trips                                      │
│  • View trip timeline                                            │
│  • Track route on map                                            │
│  • Generate AI summary                                           │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    JOURNAL MODULE                                │
│  • Voice capture with waveform                                   │
│  • Speech-to-text conversion                                     │
│  • AI content enhancement                                        │
│  • Photo/video attachment                                        │
│  • Location auto-tagging                                         │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    EXPENSE MODULE                                │
│  • Add/Edit/Delete expenses                                      │
│  • Category management                                           │
│  • Analytics dashboard                                           │
│  • Charts and visualizations                                     │
│  • Receipt scanning (OCR)                                        │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                     MEDIA MODULE                                 │
│  • Camera integration                                            │
│  • Gallery picker                                                │
│  • Image compression                                             │
│  • Video recording                                               │
│  • Media gallery view                                            │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                      AI MODULE                                   │
│  • Voice recording                                               │
│  • Speech-to-text                                                │
│  • Content generation                                            │
│  • Grammar enhancement                                           │
│  • Trip summaries                                                │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                   LOCATION MODULE                                │
│  • GPS tracking                                                  │
│  • Geocoding                                                     │
│  • Distance calculation                                          │
│  • Map integration                                               │
│  • Route visualization                                           │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                     SYNC MODULE                                  │
│  • Offline detection                                             │
│  • Local caching                                                 │
│  • Background sync                                               │
│  • Conflict resolution                                           │
│  • Queue management                                              │
└─────────────────────────────────────────────────────────────────┘
```

## 🎨 UI Component Hierarchy

```
VoyageAIApp (GetMaterialApp)
    │
    ├── SplashScreen
    │   └── AnimatedLogo + Gradient
    │
    ├── OnboardingScreen
    │   └── PageView (3 pages)
    │       └── Page Indicator
    │
    ├── LoginScreen
    │   └── Form + Buttons
    │
    └── HomeScreen (Bottom Navigation)
        ├── Home Tab
        │   ├── AppBar
        │   ├── Quick Actions (Gradient Cards)
        │   ├── Recent Trips
        │   └── FAB (New Trip)
        │
        ├── Trips Tab
        │   ├── Trip List
        │   └── Filter/Search
        │
        ├── Journal Tab
        │   ├── Entry List
        │   └── Voice Capture FAB
        │
        ├── Expenses Tab
        │   ├── Expense List
        │   └── Analytics
        │
        └── Profile Tab
            ├── User Info
            ├── Statistics
            └── Settings
```

## 🔐 State Management Flow (GetX)

```
1. User Interaction
         │
         ▼
2. Controller Method Called
         │
         ▼
3. Update Observable (.obs)
         │
         ▼
4. Obx() Widget Rebuilds
         │
         ▼
5. UI Updated
```

## 📦 Dependency Injection (GetX)

```
InitialBinding
    │
    ├── Services (permanent)
    │   ├── NetworkService
    │   ├── StorageService
    │   ├── LocationService
    │   ├── MediaService
    │   └── AIService
    │
    ├── Repositories (lazy)
    │   ├── TripRepository
    │   ├── JournalRepository
    │   ├── ExpenseRepository
    │   └── UserRepository
    │
    └── Controllers (lazy)
        ├── HomeController
        ├── TripController
        ├── JournalController
        └── ExpenseController
```

## 🚀 Build & Deploy Flow

```
Development
    │
    ├── Write Code
    ├── Run flutter analyze
    ├── Run flutter test
    └── Run flutter run
         │
         ▼
Testing
    │
    ├── Unit Tests
    ├── Widget Tests
    └── Integration Tests
         │
         ▼
Build
    │
    ├── Android: flutter build apk/appbundle
    └── iOS: flutter build ipa
         │
         ▼
Deploy
    │
    ├── Google Play Store
    └── Apple App Store
```

---

**This diagram shows the complete app architecture and flow!**
