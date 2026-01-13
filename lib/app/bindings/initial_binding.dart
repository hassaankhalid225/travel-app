import 'package:get/get.dart';

/// Initial binding for dependency injection
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize core services
    // Get.put<NetworkService>(NetworkService(), permanent: true);
    // Get.put<StorageService>(StorageService(), permanent: true);
    // Get.put<LocationService>(LocationService(), permanent: true);
    // Get.put<MediaService>(MediaService(), permanent: true);
    // Get.put<AIService>(AIService(), permanent: true);
    
    // Initialize repositories
    // Get.lazyPut<TripRepository>(() => TripRepositoryImpl());
    // Get.lazyPut<JournalRepository>(() => JournalRepositoryImpl());
    // Get.lazyPut<ExpenseRepository>(() => ExpenseRepositoryImpl());
    
    // Initialize controllers
    // Get.lazyPut<AppController>(() => AppController());
  }
}
