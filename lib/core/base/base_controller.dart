import 'package:get/get.dart';

/// Base controller with common functionality for all GetX controllers
abstract class BaseController extends GetxController {
  // Loading state
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  // Error state
  final _error = Rx<String?>(null);
  String? get error => _error.value;
  set error(String? value) => _error.value = value;

  // Success state
  final _success = Rx<String?>(null);
  String? get success => _success.value;
  set success(String? value) => _success.value = value;

  /// Show loading state
  void showLoading() {
    _isLoading.value = true;
    _error.value = null;
    _success.value = null;
  }

  /// Hide loading state
  void hideLoading() {
    _isLoading.value = false;
  }

  /// Show error message
  void showError(String message) {
    _error.value = message;
    _isLoading.value = false;
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  /// Show success message
  void showSuccess(String message) {
    _success.value = message;
    _isLoading.value = false;
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  /// Clear all states
  void clearStates() {
    _isLoading.value = false;
    _error.value = null;
    _success.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    clearStates();
  }

  @override
  void onClose() {
    clearStates();
    super.onClose();
  }
}
