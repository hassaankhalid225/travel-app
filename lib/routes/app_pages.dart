import 'package:get/get.dart';
import 'app_routes.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/onboarding/onboarding_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/trips/trips_screen.dart';
import '../presentation/screens/journal/journal_screen.dart';
import '../presentation/screens/expenses/expenses_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';

/// App pages configuration for GetX navigation
class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final routes = [
    // Splash & Onboarding
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.fadeIn,
    ),

    // Auth
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
    ),

    // Main Navigation
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.trips,
      page: () => const TripsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.journal,
      page: () => const JournalScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.expenses,
      page: () => const ExpensesScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      transition: Transition.fadeIn,
    ),

    // Settings
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
