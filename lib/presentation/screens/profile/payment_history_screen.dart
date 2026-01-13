import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {'title': 'Hotel Astoria', 'date': 'Oct 15, 2023', 'amount': '-\$420.00', 'status': 'Completed', 'category': 'Lodging'},
      {'title': 'Luigi\'s Trattoria', 'date': 'Oct 14, 2023', 'amount': '-\$85.50', 'status': 'Completed', 'category': 'Food'},
      {'title': 'Ryanair Flight FR124', 'date': 'Oct 12, 2023', 'amount': '-\$124.00', 'status': 'Completed', 'category': 'Transport'},
      {'title': 'Wallet Top-up', 'date': 'Oct 10, 2023', 'amount': '+\$1000.00', 'status': 'Completed', 'category': 'Deposit'},
      {'title': 'Museum Ticket', 'date': 'Oct 09, 2023', 'amount': '-\$25.00', 'status': 'Pending', 'category': 'Entertainment'},
    ];

    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Payments', style: AppTypography.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Container(
                decoration: BoxDecoration(gradient: AppColors.primaryGradient),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text('AVAILABLE BALANCE', style: AppTypography.labelSmall.copyWith(color: Colors.white60, letterSpacing: 2)),
                      const SizedBox(height: 8),
                      Text('\$1,245.80', style: AppTypography.headlineMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('Filter')),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final tx = transactions[index];
                final isNegative = tx['amount']!.startsWith('-');
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.grey50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getIcon(tx['category']!),
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tx['title']!, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(tx['date']!, style: AppTypography.labelSmall.copyWith(color: AppColors.grey500)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tx['amount']!,
                            style: AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isNegative ? Colors.black : Colors.green,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tx['status']!,
                            style: AppTypography.labelSmall.copyWith(
                              color: tx['status'] == 'Pending' ? Colors.orange : AppColors.grey400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1);
              },
              childCount: transactions.length,
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  IconData _getIcon(String category) {
    switch (category) {
      case 'Lodging': return Icons.hotel_rounded;
      case 'Food': return Icons.restaurant_rounded;
      case 'Transport': return Icons.flight_takeoff_rounded;
      case 'Deposit': return Icons.account_balance_wallet_rounded;
      case 'Entertainment': return Icons.confirmation_number_rounded;
      default: return Icons.payment_rounded;
    }
  }
}
