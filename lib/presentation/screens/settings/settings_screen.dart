import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SettingsController extends GetxController {
  final isDarkMode = false.obs;
  final isLocationEnabled = true.obs;
  final isBiometricsEnabled = true.obs;
}

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SettingsController>()) {
      Get.put(SettingsController());
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
          'Settings',
          style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('General'),
          const SizedBox(height: 16),
          _buildSettingTile(
            Icons.dark_mode_outlined,
            'Dark Mode',
            'Enable dark theme',
            trailing: Obx(() => Switch.adaptive(
              value: controller.isDarkMode.value,
              onChanged: (v) => controller.isDarkMode.value = v,
              activeColor: AppColors.primary,
            )),
          ),
          _buildSettingTile(
            Icons.location_on_outlined,
            'Location Services',
            'Allow app to track trips',
            trailing: Obx(() => Switch.adaptive(
              value: controller.isLocationEnabled.value,
              onChanged: (v) => controller.isLocationEnabled.value = v,
              activeColor: AppColors.primary,
            )),
          ),
          const SizedBox(height: 32),
          
          _buildSectionHeader('Privacy & Security'),
          const SizedBox(height: 16),
          _buildSettingTile(
            Icons.fingerprint,
            'Biometric Login',
            'Use FaceID or Fingerprint',
            trailing: Obx(() => Switch.adaptive(
              value: controller.isBiometricsEnabled.value,
              onChanged: (v) => controller.isBiometricsEnabled.value = v,
              activeColor: AppColors.primary,
            )),
          ),
          _buildSettingTile(Icons.security, 'Privacy Policy', 'Manage your data'),
          _buildSettingTile(Icons.description_outlined, 'Terms of Service', 'Read our legal terms'),
          const SizedBox(height: 32),

          _buildSectionHeader('Other'),
          const SizedBox(height: 16),
          _buildSettingTile(Icons.language, 'Language', 'English (US)'),
          _buildSettingTile(Icons.info_outline, 'App Version', 'v1.0.4 build 102'),
          
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'Log Out',
                style: AppTypography.buttonLarge.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
        ].animate(interval: 50.ms).fadeIn(duration: 400.ms).slideX(begin: 0.1),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTypography.labelSmall.copyWith(
        color: AppColors.grey500,
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle, {Widget? trailing}) {
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(
          title,
          style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.labelSmall.copyWith(color: AppColors.grey500),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.grey300),
        onTap: trailing == null ? () {} : null,
      ),
    );
  }
}
