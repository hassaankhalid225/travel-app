import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _navigateToNext();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    animationController.forward();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    
    // Check if first launch
    // final prefs = await SharedPreferences.getInstance();
    // final isFirstLaunch = prefs.getBool(AppConstants.isFirstLaunchKey) ?? true;
    
    // For now, always go to onboarding
    Get.offAllNamed('/onboarding');
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already done
    if (!Get.isRegistered<SplashController>()) {
      Get.put(SplashController());
    }
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                
                // App Logo with Animation
                AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: ScaleTransition(
                        scale: controller.scaleAnimation,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.flight_takeoff_rounded,
                            size: 60,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 32),
                
                // App Name with Animation
                AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: controller.slideAnimation,
                      child: FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: Column(
                          children: [
                            Text(
                              AppConstants.appName,
                              style: AppTypography.displaySmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppConstants.appTagline,
                              style: AppTypography.bodyLarge.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const Spacer(flex: 3),
                
                // Loading Indicator
                AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
