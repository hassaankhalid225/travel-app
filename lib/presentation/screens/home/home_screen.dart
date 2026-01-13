import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../capture/voice_capture_screen.dart';
import '../expenses/expenses_screen.dart';
import '../map/route_tracking_screen.dart';
import '../trips/trip_details_screen.dart';
import '../journal/journal_screen.dart';
import '../settings/settings_screen.dart';
import '../profile/personal_info_screen.dart';
import '../profile/notification_settings_screen.dart';
import '../profile/payment_history_screen.dart';
import '../notifications/notifications_screen.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;
  final carouselIndex = 0.obs;
  final selectedCategory = 0.obs;
  
  void changePage(int index) => currentIndex.value = index;
  void changeCarouselPage(int index) => carouselIndex.value = index;
  void selectCategory(int index) => selectedCategory.value = index;
}

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HomeController>()) Get.put(HomeController());
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: controller.currentIndex.value,
        children: const [
          _DashboardPage(),
          _ExplorePage(),
          JournalScreen(),
          _ProfilePage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }

  Widget _buildFAB() {
    return Container(
      width: 64, height: 64,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.to(() => const VoiceCaptureScreen()),
          borderRadius: BorderRadius.circular(32),
          child: const Icon(Icons.mic_rounded, color: Colors.white, size: 32),
        ),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: const Duration(seconds: 2));
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5))]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(0, Icons.home_rounded, 'Home'),
              _buildNavItem(1, Icons.explore_rounded, 'Explore'),
              const SizedBox(width: 64),
              _buildNavItem(2, Icons.book_rounded, 'Journal'),
              _buildNavItem(3, Icons.person_rounded, 'Profile'),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = controller.currentIndex.value == index;
    return InkWell(
      onTap: () => controller.changePage(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.grey400, size: 26),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.labelSmall.copyWith(color: isSelected ? AppColors.primary : AppColors.grey400, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60), // Status bar spacer
          // 1. Header: Location & Notification
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Location', style: AppTypography.labelSmall.copyWith(color: AppColors.grey400)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: AppColors.primary, size: 18),
                        const SizedBox(width: 4),
                        Text('Lombok, Indonesia', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                        const Icon(Icons.keyboard_arrow_down, color: AppColors.grey400),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const NotificationsScreen()),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
                    ),
                    child: Stack(
                      children: [
                        const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
                        Positioned(
                          right: 2, top: 2,
                          child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle, border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)))),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: -0.2),

          // 2. Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: AppColors.grey400),
                        const SizedBox(width: 12),
                        Text('Discover a city...', style: AppTypography.bodyMedium.copyWith(color: AppColors.grey400)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 56, width: 56,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.tune_rounded, color: Colors.white),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 100.ms),

          // 3. Categories
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                _buildCat(0, Icons.grid_view_rounded, 'all'),
                _buildCat(1, null, 'Indonesia', flag: '🇮🇩'),
                _buildCat(2, null, 'Thailand', flag: '🇹🇭'),
                _buildCat(3, null, 'Japan', flag: '🇯🇵'),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms),

          // 4. Nearby
          const SizedBox(height: 32),
          _buildSectionHeader('Nearby Destination'),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _buildNearby('Beautiful old building', 'Yogyakarta', '165,3', 5.0, 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=400'),
                _buildNearby('Coastal Villa', 'Bali', '245,0', 4.8, 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=400'),
              ],
            ),
          ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1),

          // 5. Recommendation
          const SizedBox(height: 32),
          _buildSectionHeader('Recommendation'),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildRecItem('Tropical Paradise', 'Surabaya', '120,5', 4.5, 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400'),
                _buildRecItem('Mountain Retreat', 'Bandung', '95,0', 4.7, 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=400'),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold)),
          Text('See all', style: AppTypography.labelMedium.copyWith(color: AppColors.grey400)),
        ],
      ),
    );
  }

  Widget _buildCat(int index, IconData? icon, String label, {String? flag}) {
    final controller = Get.find<HomeController>();
    return Obx(() {
      final isSelected = controller.selectedCategory.value == index;
      return GestureDetector(
        onTap: () => controller.selectCategory(index),
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.textPrimary : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: isSelected ? Colors.transparent : AppColors.grey100),
          ),
          child: Row(
            children: [
              if (icon != null) Icon(icon, color: isSelected ? Colors.white : AppColors.textPrimary, size: 20),
              if (flag != null) Text(flag, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(label, style: AppTypography.bodyMedium.copyWith(color: isSelected ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildNearby(String title, String loc, String price, double rating, String img) {
    return GestureDetector(
      onTap: () => Get.to(() => const TripDetailsScreen()),
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(24), child: Image.network(img, height: 200, width: 240, fit: BoxFit.cover)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(title, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold), maxLines: 1)),
                Row(children: [const Icon(Icons.star, color: Colors.amber, size: 16), const SizedBox(width: 4), Text(rating.toString())]),
              ],
            ),
            const SizedBox(height: 4),
            Row(children: [const Icon(Icons.location_on, color: AppColors.grey400, size: 14), const SizedBox(width: 4), Text(loc, style: TextStyle(color: AppColors.grey400))]),
          ],
        ),
      ),
    );
  }

  Widget _buildRecItem(String title, String loc, String price, double rating, String img) {
    return GestureDetector(
      onTap: () => Get.to(() => const TripDetailsScreen()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10)]),
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network(img, width: 80, height: 80, fit: BoxFit.cover)),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(loc, style: TextStyle(color: AppColors.grey400))])),
            Text('\$$price', style: AppTypography.titleMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _ExplorePage extends StatelessWidget {
  const _ExplorePage();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                  child: Text('EXPLORE THE WORLD', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ),
                const SizedBox(height: 16),
                Text('Discovery', style: AppTypography.headlineLarge.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 60,
                  decoration: BoxDecoration(color: AppColors.grey50, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.grey100)),
                  child: const Row(children: [Icon(Icons.search, color: AppColors.primary), SizedBox(width: 12), Text('Search destinations...', style: TextStyle(color: AppColors.grey400))]),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverToBoxAdapter(child: Text('Trending Trips', style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold))),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _exploreCard('Santorini, Greece', 'Starting from \$240', 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=600'),
              _exploreCard('Bali, Indonesia', 'Starting from \$120', 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=600'),
              _exploreCard('Swiss Alps', 'Starting from \$450', 'https://images.unsplash.com/photo-1531210483974-4f8c1f33fd35?w=600'),
            ].animate(interval: 100.ms).fadeIn().slideY(begin: 0.2)),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _exploreCard(String title, String price, String img) {
    return GestureDetector(
      onTap: () => Get.to(() => const TripDetailsScreen()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)])),
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: AppTypography.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)), Text(price, style: const TextStyle(color: Colors.white70))]),
        ),
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24, bottom: 32),
            decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40))),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Profile', style: AppTypography.headlineMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)), IconButton(onPressed: () => Get.to(() => const SettingsScreen()), icon: const Icon(Icons.settings_outlined, color: Colors.white))]),
                const SizedBox(height: 32),
                Stack(alignment: Alignment.bottomRight, children: [Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle), child: const CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400'))), Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 14))]).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                const SizedBox(height: 16),
                Text('Alex Thompson', style: AppTypography.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('PRO TRAVELER • LEVEL 12', style: AppTypography.labelSmall.copyWith(color: Colors.white70, letterSpacing: 2)),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildStat('24', 'Trips'), _buildStat('12', 'Countries'), _buildStat('156', 'Memories')]))),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text('Account Settings', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              const SizedBox(height: 16),
              _buildMenuItem(Icons.person_outline, 'Personal Information', 'Name, Email, Phone', () => Get.to(() => const PersonalInfoScreen())),
              _buildMenuItem(Icons.receipt_long_outlined, 'My Expenses', 'Track your travel spending', () => Get.to(() => const ExpensesScreen())),
              _buildMenuItem(Icons.payment_outlined, 'Payments & Payouts', 'History, Currency, Limits', () => Get.to(() => const PaymentHistoryScreen())),
              _buildMenuItem(Icons.notifications_active_outlined, 'Notifications', 'App sounds, Push alerts', () => Get.to(() => const NotificationSettingsScreen())),
              const SizedBox(height: 32),
              Text('Support', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              const SizedBox(height: 16),
              _buildMenuItem(Icons.help_center_outlined, 'Help Center', 'FAQs, Contact support', () {}),
              _buildMenuItem(Icons.info_outline, 'Terms of Service', 'Usage policy, Legal', () {}),
              const SizedBox(height: 120),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String val, String lbl) => Column(children: [Text(val, style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary)), Text(lbl, style: AppTypography.labelSmall.copyWith(color: AppColors.grey500))]);

  Widget _buildMenuItem(IconData icon, String title, String sub, VoidCallback onTap) => Container(margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10)]), child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), leading: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: AppColors.primary, size: 22)), title: Text(title, style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.bold)), subtitle: Text(sub, style: AppTypography.labelSmall.copyWith(color: AppColors.grey500)), trailing: const Icon(Icons.chevron_right, color: AppColors.grey300), onTap: onTap));
}
