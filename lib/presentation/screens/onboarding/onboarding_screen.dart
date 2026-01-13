import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: 'Craft Your Journey',
      description: 'Turn your voice notes and photos into timeless digital travel books with AI.',
      imageUrl: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800',
    ),
    OnboardingPageData(
      title: 'AI Storytelling',
      description: 'Your voice notes transform into beautifully written travel stories automatically.',
      imageUrl: 'https://images.unsplash.com/photo-1503221043305-f7498f8b7888?w=800',
    ),
    OnboardingPageData(
      title: 'Global Memories',
      description: 'Auto-tagged locations, expenses, and memories. Ready to share with the world.',
      imageUrl: 'https://images.unsplash.com/photo-1488085061387-422e29b40080?w=800',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  void skip() {
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingPageData {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingPageData({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background Images PageView
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.pages.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    controller.pages[index].imageUrl,
                    fit: BoxFit.cover,
                  ).animate().scale(
                    begin: const Offset(1.1, 1.1),
                    end: const Offset(1.0, 1.0),
                    duration: const Duration(seconds: 30),
                    curve: Curves.linear,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: controller.skip,
                      child: Text(
                        'Skip',
                        style: AppTypography.labelLarge.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 500)).slideX(begin: 0.2),
                ),
                const Spacer(),
                
                // Animated Glassmorphic Card
                Obx(() {
                  final page = controller.pages[controller.currentPage.value];
                  return GlassmorphicContainer(
                    width: Get.width * 0.85,
                    height: 360,
                    borderRadius: 32,
                    blur: 20,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                    ),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.5),
                        Colors.white.withValues(alpha: 0.2),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          SmoothPageIndicator(
                            controller: controller.pageController,
                            count: controller.pages.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 6,
                              dotWidth: 6,
                              activeDotColor: AppColors.primary,
                              dotColor: Colors.white30,
                              spacing: 8,
                            ),
                          ).animate().fadeIn(delay: const Duration(milliseconds: 800)),
                          const SizedBox(height: 32),
                          Text(
                            page.title,
                            key: ValueKey('title_${controller.currentPage.value}'),
                            style: AppTypography.headlineLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ).animate(key: ValueKey('anim_title_${controller.currentPage.value}'))
                            .fadeIn(duration: const Duration(milliseconds: 400))
                            .slideY(begin: 0.2),
                          const SizedBox(height: 16),
                          Text(
                            page.description,
                            key: ValueKey('desc_${controller.currentPage.value}'),
                            style: AppTypography.bodyLarge.copyWith(
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ).animate(key: ValueKey('anim_desc_${controller.currentPage.value}'))
                            .fadeIn(duration: const Duration(milliseconds: 400), delay: const Duration(milliseconds: 100))
                            .slideY(begin: 0.2),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: controller.nextPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.currentPage.value == controller.pages.length - 1
                                        ? 'Begin Voyage'
                                        : 'Next',
                                    style: AppTypography.buttonLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward_rounded, size: 20),
                                ],
                              ),
                            ),
                          ).animate().fadeIn(delay: const Duration(milliseconds: 300)).scale(delay: const Duration(milliseconds: 300)),
                        ],
                      ),
                    ),
                  ),
                ).animate(key: ValueKey('card_${controller.currentPage.value}'))
                  .fadeIn(duration: const Duration(milliseconds: 600))
                  .slideY(begin: 0.3, curve: Curves.easeOutCubic);
              }),
                
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Already have an account? Log in',
                    style: AppTypography.bodyMedium.copyWith(color: Colors.white60),
                  ),
                ).animate().fadeIn(delay: const Duration(seconds: 1)),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
