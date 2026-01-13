import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class ExpensesController extends GetxController {
  final totalSpent = 2450.0.obs;
  final remainingBudget = 550.0.obs;
}

class ExpensesScreen extends GetView<ExpensesController> {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ExpensesController>()) {
      Get.put(ExpensesController());
    }

    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                  ),
                  Text(
                    'Paris Trip 2024',
                    style: AppTypography.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: -0.2),

            // Date Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today, color: AppColors.primary, size: 14),
                  const SizedBox(width: 8),
                  Text(
                    'Oct 12 - Oct 20',
                    style: AppTypography.labelSmall.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 200)),

            const SizedBox(height: 40),

            // Radial Expense Chart
            SizedBox(
              height: 240,
              width: 240,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 90,
                      startDegreeOffset: -90,
                      sections: [
                        PieChartSectionData(
                          color: AppColors.primary,
                          value: 75,
                          radius: 12,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          color: Colors.white.withValues(alpha: 0.1),
                          value: 25,
                          radius: 12,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ).animate().scale(delay: const Duration(milliseconds: 400), duration: const Duration(milliseconds: 800), curve: Curves.elasticOut),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Spent',
                        style: AppTypography.labelMedium.copyWith(color: Colors.white54),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$2,450',
                        style: AppTypography.headlineMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$550 Remaining',
                        style: AppTypography.labelSmall.copyWith(color: AppColors.secondary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ).animate().fadeIn(delay: const Duration(milliseconds: 800)),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // Expenses List Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expenses',
                    style: AppTypography.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See All', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 600)),

            // Expense Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildExpenseCard(
                    'Stay',
                    'Hotel & Airbnb',
                    '\$1,200',
                    0.8,
                    Icons.hotel_rounded,
                    const Color(0xFF6366F1),
                  ),
                  _buildExpenseCard(
                    'Food',
                    'Restaurants & Cafés',
                    '\$850',
                    0.65,
                    Icons.restaurant_rounded,
                    const Color(0xFFF59E0B),
                  ),
                  _buildExpenseCard(
                    'Travel',
                    'Flights & Uber',
                    '\$400',
                    0.45,
                    Icons.flight_takeoff_rounded,
                    const Color(0xFF10B981),
                  ),
                ],
              ).animate().fadeIn(delay: const Duration(milliseconds: 800)).slideX(begin: 0.1),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
      ).animate().scale(delay: const Duration(milliseconds: 1200)),
    );
  }

  Widget _buildExpenseCard(String title, String subtitle, String amount, double progress, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: AppTypography.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(amount, style: AppTypography.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTypography.bodySmall.copyWith(color: Colors.white54)),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4, spreadRadius: 1),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
