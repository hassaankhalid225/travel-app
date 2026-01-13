import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class NotificationSettingsController extends GetxController {
  final tripReminders = true.obs;
  final expenseAlerts = true.obs;
  final mapUpdates = false.obs;
  final achievementPopups = true.obs;
  final newsletter = false.obs;
}

class NotificationSettingsScreen extends GetView<NotificationSettingsController> {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<NotificationSettingsController>()) {
      Get.put(NotificationSettingsController());
    }

    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifications',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSection('Trip Updates'),
          _buildToggleTile('Trip Reminders', 'Get notified about upcoming flights', controller.tripReminders),
          _buildToggleTile('Route Changes', 'Live updates on your tracking route', controller.mapUpdates),
          
          const SizedBox(height: 32),
          _buildSection('Finances'),
          _buildToggleTile('Expense Alerts', 'Budget warnings and spending summaries', controller.expenseAlerts),
          
          const SizedBox(height: 32),
          _buildSection('Social & Rewards'),
          _buildToggleTile('Achievements', 'When you reach new traveler levels', controller.achievementPopups),
          _buildToggleTile('Newsletter', 'Weekly travel tips and AI insights', controller.newsletter),
          
          const SizedBox(height: 48),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('Reset to default settings', style: TextStyle(color: AppColors.grey400)),
            ),
          ).animate().fadeIn(delay: 800.ms),
        ].animate(interval: 50.ms).fadeIn().slideY(begin: 0.1),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 4),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.grey500,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildToggleTile(String title, String subtitle, RxBool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(() => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: AppTypography.labelSmall.copyWith(color: AppColors.grey500)),
        trailing: Switch.adaptive(
          value: value.value,
          onChanged: (v) => value.value = v,
          activeColor: AppColors.primary,
        ),
      )),
    );
  }
}
