# 🌍 Voyage AI - AI-Powered Travel Journal App

> **Your Intelligent Travel Memory Companion**

Voyage AI is an intelligent travel journaling app that automatically transforms real-world journeys into beautifully structured digital travel books using voice, photos, videos, and location data.

## ✨ Features

### Core Features
- 🎙️ **Voice-to-Journal**: Speak your thoughts, AI converts them to beautiful travel stories
- 📸 **Smart Media Management**: Automatic photo/video organization with location tagging
- 🗺️ **Route Tracking**: Automatic travel distance and route mapping
- 💰 **Expense Tracking**: Categorized spending with visual analytics
- 🤖 **AI-Powered Storytelling**: Google Gemini AI enhances your voice notes
- 📴 **Offline Support**: Full functionality without internet, auto-sync when online
- 📊 **Trip Analytics**: Visual summaries, timelines, and insights

### Premium Design
- 🎨 Glassmorphism UI with Apple-style aesthetics
- 🌈 Vibrant gradients and smooth animations
- 📱 One-handed usage with gesture-based navigation
- 🎭 Immersive 3D illustrations
- ✨ Micro-interactions and smooth transitions

## 🏗️ Architecture

This app follows **Clean Architecture** principles with a modular, scalable structure:

\`\`\`
lib/
├── app/                    # App-level configuration
│   └── bindings/          # Dependency injection bindings
├── core/                   # Core utilities & shared resources
│   ├── base/              # Base classes (BaseController, etc.)
│   ├── constants/         # App constants
│   ├── errors/            # Custom exceptions
│   ├── network/           # Network utilities
│   └── theme/             # Theme, colors, typography
├── data/                   # Data layer
│   ├── models/            # Data models (JSON serializable)
│   ├── repositories/      # Repository implementations
│   ├── services/          # API services, local storage
│   └── sources/           # Data sources (remote/local)
├── domain/                 # Business logic layer
│   ├── entities/          # Business entities
│   ├── repositories/      # Repository interfaces
│   └── usecases/          # Business use cases
├── presentation/           # UI layer
│   ├── screens/           # App screens
│   ├── widgets/           # Reusable widgets
│   └── controllers/       # GetX controllers
├── routes/                 # Navigation & routing
└── main.dart              # App entry point
\`\`\`

## 🛠️ Tech Stack

### State Management
- **GetX** - Reactive state management, dependency injection, and routing

### Local Storage
- **Hive** - Fast, lightweight NoSQL database
- **SQLite** - Structured data storage
- **SharedPreferences** - Simple key-value storage

### Networking
- **Dio** - HTTP client with interceptors
- **Retrofit** - Type-safe REST client
- **Connectivity Plus** - Network status monitoring

### Location & Maps
- **Geolocator** - Location services
- **Google Maps Flutter** - Interactive maps
- **Geocoding** - Address lookup

### Media
- **Image Picker** - Photo/video selection
- **Camera** - In-app camera
- **Video Player** - Video playback
- **Cached Network Image** - Image caching

### AI & Speech
- **Google Generative AI** - Gemini AI integration
- **Speech to Text** - Voice recognition
- **Flutter Sound** - Audio recording

### UI Components
- **Glassmorphism** - Frosted glass effects
- **Lottie** - Animations
- **Shimmer** - Loading placeholders
- **FL Chart** - Data visualization

## 📱 Screens

### Onboarding & Auth
- ✅ Splash Screen (with animations)
- ✅ Onboarding (3 pages with smooth transitions)
- ✅ Login/Register
- ⏳ Forgot Password

### Main Navigation
- ✅ Home Dashboard
- ⏳ Trips List
- ⏳ Journal Entries
- ⏳ Expense Tracker
- ⏳ Profile

### Trip Management
- ⏳ Create Trip
- ⏳ Trip Details
- ⏳ Trip Timeline
- ⏳ Trip Map View
- ⏳ AI-Generated Summary

### Journal
- ⏳ Create Entry
- ⏳ Voice Capture (with waveform animation)
- ⏳ AI Processing
- ⏳ Entry Details
- ⏳ Media Gallery

### Expenses
- ⏳ Add Expense
- ⏳ Expense Analytics
- ⏳ Category Breakdown
- ⏳ Receipt Scanner

## 🎨 Design System

### Colors
- **Primary**: Indigo (#6366F1)
- **Secondary**: Pink (#EC4899)
- **Accent**: Teal (#14B8A6)
- **Gradients**: Multiple premium gradients for different contexts

### Typography
- **Primary Font**: Inter (body text, UI elements)
- **Secondary Font**: Outfit (headlines, hero text)
- Comprehensive type scale following Material Design 3

### Components
- Glassmorphic cards with blur effects
- Gradient buttons and action cards
- Custom bottom navigation
- Smooth page transitions

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10.3 or higher)
- Dart SDK
- Android Studio / Xcode
- Google Maps API Key
- Gemini API Key

### Installation

1. **Clone the repository**
\`\`\`bash
git clone <repository-url>
cd travel_app
\`\`\`

2. **Install dependencies**
\`\`\`bash
flutter pub get
\`\`\`

3. **Configure API Keys**

Edit \`lib/core/constants/app_constants.dart\`:
\`\`\`dart
static const String geminiApiKey = 'YOUR_GEMINI_API_KEY';
\`\`\`

4. **Run the app**
\`\`\`bash
flutter run
\`\`\`

### Code Generation

For models and repositories:
\`\`\`bash
flutter pub run build_runner build --delete-conflicting-outputs
\`\`\`

## 📦 Project Structure Details

### Domain Layer (Business Logic)
- **Entities**: Pure Dart classes representing business objects
  - User, Trip, JournalEntry, Expense, Media
- **Use Cases**: Single-responsibility business operations
- **Repository Interfaces**: Contracts for data operations

### Data Layer
- **Models**: JSON-serializable data transfer objects
- **Repositories**: Implementations of domain repositories
- **Services**: 
  - NetworkService (API calls)
  - StorageService (local data)
  - LocationService (GPS, geocoding)
  - MediaService (camera, gallery)
  - AIService (Gemini integration)

### Presentation Layer
- **Controllers**: GetX controllers for state management
- **Screens**: Full-page views
- **Widgets**: Reusable UI components

## 🔧 Development Guidelines

### State Management with GetX
\`\`\`dart
// Controller
class MyController extends BaseController {
  final _data = Rx<Data?>(null);
  Data? get data => _data.value;
  
  Future<void> loadData() async {
    showLoading();
    try {
      final result = await repository.getData();
      _data.value = result;
      hideLoading();
    } catch (e) {
      showError(e.toString());
    }
  }
}

// View
class MyScreen extends GetView<MyController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading 
      ? LoadingWidget() 
      : DataWidget(controller.data));
  }
}
\`\`\`

### Dependency Injection
\`\`\`dart
// In bindings
Get.lazyPut<MyController>(() => MyController());

// In screen
Get.put(MyController());
\`\`\`

### Navigation
\`\`\`dart
// Navigate to screen
Get.toNamed(AppRoutes.tripDetails, arguments: tripId);

// Get arguments
final tripId = Get.arguments as String;

// Go back
Get.back(result: data);
\`\`\`

## 🎯 Roadmap

### Phase 1: Foundation (Current)
- [x] Project setup and architecture
- [x] Core theme and design system
- [x] Navigation structure
- [x] Basic screens (Splash, Onboarding, Login, Home)
- [ ] Domain entities and models

### Phase 2: Core Features
- [ ] Trip management (CRUD)
- [ ] Journal entries with voice
- [ ] Media capture and storage
- [ ] Location tracking
- [ ] Offline support

### Phase 3: AI Integration
- [ ] Speech-to-text conversion
- [ ] AI story generation
- [ ] Content enhancement
- [ ] Auto-tagging

### Phase 4: Analytics & Insights
- [ ] Expense tracking
- [ ] Visual analytics
- [ ] Trip summaries
- [ ] Export functionality

### Phase 5: Polish
- [ ] Animations and transitions
- [ ] Performance optimization
- [ ] Testing
- [ ] App store deployment

## 📝 License

This project is private and proprietary.

## 👨‍💻 Developer Notes

### Key Patterns
1. **Separation of Concerns**: Each layer has a single responsibility
2. **Dependency Inversion**: High-level modules don't depend on low-level modules
3. **Component-Based**: Everything is a reusable component
4. **Reactive Programming**: Using GetX observables for state management

### Best Practices
- Use \`const\` constructors wherever possible
- Follow the DRY principle
- Write self-documenting code
- Keep controllers thin, move logic to use cases
- Use meaningful variable names
- Add comments for complex logic

### Performance Tips
- Use \`GetView\` instead of \`StatelessWidget\` for GetX screens
- Lazy load controllers with \`Get.lazyPut\`
- Cache images and data appropriately
- Optimize list rendering with \`ListView.builder\`
- Use \`const\` widgets to reduce rebuilds

---

**Built with ❤️ using Flutter & GetX**
#   t r a v e l - a p p  
 