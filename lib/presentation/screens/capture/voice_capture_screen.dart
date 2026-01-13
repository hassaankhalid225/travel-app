import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class VoiceCaptureController extends GetxController with GetSingleTickerProviderStateMixin {
  final isRecording = false.obs;
  late AnimationController waveController;

  @override
  void onInit() {
    super.onInit();
    waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  void toggleRecording() {
    isRecording.value = !isRecording.value;
  }

  @override
  void onClose() {
    waveController.dispose();
    super.onClose();
  }
}

class VoiceCaptureScreen extends GetView<VoiceCaptureController> {
  const VoiceCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<VoiceCaptureController>()) {
      Get.put(VoiceCaptureController());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image with Blur/Dim
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Image.network(
                'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=800',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                  Colors.black,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: AppColors.primary, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              'KYOTO, DAY 3',
                              style: AppTypography.labelSmall.copyWith(color: Colors.white, letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ).animate().fadeIn().slideY(begin: -0.2),

                  const SizedBox(height: 40),
                  
                  // Subtitles / Story
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTypography.headlineMedium.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                            ),
                            children: [
                              const TextSpan(text: '"The coffee at this café is '),
                              TextSpan(
                                text: 'incredible',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 10),
                                  ],
                                ),
                              ),
                              const TextSpan(text: ', looking out over the Seine..."'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 500)).slideY(begin: 0.1),

                  const SizedBox(height: 60),

                  // Waveform Container
                  SizedBox(
                    height: 120,
                    child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(24, (index) {
                        // Accessing observable here for Obx to track
                        final active = controller.isRecording.value;
                        return AnimatedBuilder(
                          animation: controller.waveController,
                          builder: (context, child) {
                            double value = active 
                                ? math.sin(controller.waveController.value * 2 * math.pi + index * 0.5) 
                                : 0;
                            double height = 12 + (value.abs() * 70) + (index % 4 * 4);
                            return Container(
                              width: 3.5,
                              height: height,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: active ? AppColors.primary : Colors.white24,
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: active ? [
                                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 4),
                                ] : [],
                              ),
                            );
                          },
                        );
                      }),
                    )),
                  ),

                  const SizedBox(height: 60),

                  // Buttons Row
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildMiniButton(Icons.close, 'CANCEL', Colors.white30),
                        
                        // Large Record Button
                        GestureDetector(
                          onTap: controller.toggleRecording,
                          child: Obx(() {
                            final recording = controller.isRecording.value;
                            return Container(
                              width: 84,
                              height: 84,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    blurRadius: 30,
                                    spreadRadius: recording ? 10 : 0,
                                  ),
                                  if (recording)
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.2),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                ],
                              ),
                              child: Icon(
                                recording ? Icons.stop_rounded : Icons.mic_rounded,
                                size: 42,
                                color: Colors.black,
                              ),
                            );
                          }).animate(target: controller.isRecording.value ? 1 : 0)
                            .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: const Duration(milliseconds: 200)),
                        ),
                        
                        _buildMiniButton(Icons.pause, 'PAUSE', Colors.white30),
                      ],
                    ),
                  ).animate().fadeIn(delay: const Duration(seconds: 1)).slideY(begin: 0.2),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }
}
