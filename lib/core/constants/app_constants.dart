/// App-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Voyage AI';
  static const String appTagline = 'Your Intelligent Travel Memory Companion';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl = 'https://api.voyageai.com/v1';
  static const String apiKey = 'YOUR_API_KEY_HERE';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Google AI Configuration
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY';

  // Storage Keys
  static const String userBoxKey = 'user_box';
  static const String tripBoxKey = 'trip_box';
  static const String journalBoxKey = 'journal_box';
  static const String expenseBoxKey = 'expense_box';
  static const String mediaBoxKey = 'media_box';
  static const String settingsBoxKey = 'settings_box';

  // SharedPreferences Keys
  static const String isFirstLaunchKey = 'is_first_launch';
  static const String isLoggedInKey = 'is_logged_in';
  static const String userIdKey = 'user_id';
  static const String authTokenKey = 'auth_token';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Media
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50MB
  static const int maxAudioDuration = 300; // 5 minutes in seconds
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png', 'heic'];
  static const List<String> supportedVideoFormats = ['mp4', 'mov', 'avi'];

  // Location
  static const double defaultLatitude = 0.0;
  static const double defaultLongitude = 0.0;
  static const double locationAccuracyThreshold = 50.0; // meters

  // Offline Sync
  static const Duration syncInterval = Duration(minutes: 15);
  static const int maxRetryAttempts = 3;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 16.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 24.0;

  // Voice Recording
  static const int minRecordingDuration = 1; // seconds
  static const int maxRecordingDuration = 600; // 10 minutes
  static const String audioFormat = 'aac';

  // AI Processing
  static const int maxTokensPerRequest = 2000;
  static const double aiTemperature = 0.7;
  static const int maxRetryForAI = 2;

  // Expense Categories
  static const List<String> expenseCategories = [
    'Accommodation',
    'Food & Dining',
    'Transportation',
    'Activities',
    'Shopping',
    'Entertainment',
    'Others',
  ];

  // Currencies
  static const List<String> supportedCurrencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'AUD',
    'CAD',
    'INR',
  ];

  // Date Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'MMM dd, yyyy hh:mm a';
  static const String fullDateFormat = 'EEEE, MMMM dd, yyyy';
}
