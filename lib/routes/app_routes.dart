/// Route names for navigation
class AppRoutes {
  AppRoutes._();

  // Onboarding & Auth
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main Navigation
  static const String home = '/home';
  static const String trips = '/trips';
  static const String journal = '/journal';
  static const String expenses = '/expenses';
  static const String profile = '/profile';

  // Trip Management
  static const String createTrip = '/create-trip';
  static const String tripDetails = '/trip-details';
  static const String editTrip = '/edit-trip';
  static const String tripTimeline = '/trip-timeline';
  static const String tripMap = '/trip-map';
  static const String tripSummary = '/trip-summary';

  // Journal
  static const String createJournal = '/create-journal';
  static const String journalDetails = '/journal-details';
  static const String editJournal = '/edit-journal';
  static const String voiceCapture = '/voice-capture';
  static const String aiProcessing = '/ai-processing';

  // Media
  static const String mediaGallery = '/media-gallery';
  static const String mediaViewer = '/media-viewer';
  static const String camera = '/camera';
  static const String videoPlayer = '/video-player';

  // Expenses
  static const String createExpense = '/create-expense';
  static const String expenseDetails = '/expense-details';
  static const String editExpense = '/edit-expense';
  static const String expenseAnalytics = '/expense-analytics';

  // Map & Location
  static const String mapView = '/map-view';
  static const String locationPicker = '/location-picker';
  static const String routeTracking = '/route-tracking';

  // Settings
  static const String settings = '/settings';
  static const String accountSettings = '/account-settings';
  static const String privacySettings = '/privacy-settings';
  static const String notificationSettings = '/notification-settings';
  static const String aboutApp = '/about-app';

  // Share & Export
  static const String shareTrip = '/share-trip';
  static const String exportOptions = '/export-options';
}
