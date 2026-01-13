import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../expenses/expenses_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'High Expense Alert',
        'desc': 'You spent \$420 on Hotel Astoria. This is 20% above your daily budget.',
        'time': '2h ago',
        'icon': Icons.warning_rounded,
        'color': Colors.orange,
        'type': 'expense',
      },
      {
        'title': 'New Trip Memory',
        'desc': 'Alex shared a new photo from Tuscany Escape.',
        'time': '5h ago',
        'icon': Icons.photo_library_rounded,
        'color': AppColors.primary,
        'type': 'social',
      },
      {
        'title': 'Flight Reminder',
        'desc': 'Your flight AF124 to Paris departs in 3 hours. Check-in now!',
        'time': '8h ago',
        'icon': Icons.flight_takeoff_rounded,
        'color': Colors.blue,
        'type': 'trip',
      },
      {
        'title': 'Budget Goal Reached',
        'desc': 'Great job! You stayed under budget for 3 days straight.',
        'time': '1d ago',
        'icon': Icons.account_balance_wallet_rounded,
        'color': Colors.green,
        'type': 'expense',
      },
    ];

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
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];
          return _buildNotificationCard(n);
        },
      ).animate().fadeIn().slideY(begin: 0.1),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> n) {
    return GestureDetector(
      onTap: () {
        if (n['type'] == 'expense') {
          Get.to(() => const ExpensesScreen());
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (n['color'] as Color).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(n['title'] as String, style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.bold)),
                      Text(n['time'] as String, style: AppTypography.labelSmall.copyWith(color: AppColors.grey400)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    n['desc'] as String,
                    style: AppTypography.bodySmall.copyWith(color: AppColors.grey500, height: 1.4),
                  ),
                  if (n['type'] == 'expense') ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.receipt_long_rounded, color: AppColors.primary, size: 14),
                          const SizedBox(width: 6),
                          Text('View Expenses', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
