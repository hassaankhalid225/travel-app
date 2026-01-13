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

class HomeController extends GetxController {
  final currentIndex = 0.obs;
  final carouselIndex = 0.obs;
  void changePage(int index) => currentIndex.value = index;
  void changeCarouselPage(int index) => carouselIndex.value = index;
}

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HomeController>()) Get.put(HomeController());
    return Obx(() => Scaffold(
      body: _getPage(controller.currentIndex.value),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0: return const _HomePage();
      case 1: return const _ExplorePage();
      case 2: return const JournalScreen();
      case 3: return const _ProfilePage();
      default: return const _HomePage();
    }
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

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final now = DateTime.now();
    final dateFormat = DateFormat('EEEE, MMM dd');
    
    final journeys = [
      {'title': 'Tuscany\nEscape', 'location': 'Italy', 'image': 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=800', 'temp': '23°C', 'day': 4, 'total': 7, 'progress': 0.57},
      {'title': 'Paris\nAdventure', 'location': 'France', 'image': 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800', 'temp': '18°C', 'day': 2, 'total': 5, 'progress': 0.40},
    ];

    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(dateFormat.format(now).toUpperCase(), style: AppTypography.labelSmall.copyWith(color: AppColors.grey500)),
                    const SizedBox(height: 4),
                    Text('Welcome back, Alex', style: AppTypography.headlineSmall.copyWith(fontWeight: FontWeight.bold)),
                  ]),
                  GestureDetector(
                    onTap: () => Get.to(() => const ExpensesScreen()),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]),
                      child: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ).animate().fadeIn().slideX(begin: -0.2),
              
              const SizedBox(height: 24),
              
              // Carousel
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 20)]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Current Journeys', style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w600)),
                          TextButton(onPressed: () => Get.to(() => const TripDetailsScreen()), child: Text('View Details', style: AppTypography.labelMedium.copyWith(color: AppColors.primary))),
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                      itemCount: journeys.length,
                      options: CarouselOptions(height: 280, viewportFraction: 0.85, enlargeCenterPage: true, enableInfiniteScroll: false, onPageChanged: (i, _) => controller.changeCarouselPage(i)),
                      itemBuilder: (ctx, i, _) => _buildJourneyCard(journeys[i]),
                    ),
                    const SizedBox(height: 16),
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(journeys.length, (i) => Container(width: controller.carouselIndex.value == i ? 24 : 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: controller.carouselIndex.value == i ? AppColors.primary : AppColors.grey300))),
                    )),
                    const SizedBox(height: 16),
                  ],
                ),
              ).animate().fadeIn(delay: const Duration(milliseconds: 200)).slideY(begin: 0.1),
              
              const SizedBox(height: 32),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today's Highlights", style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () => Get.to(() => const RouteTrackingScreen()), child: Text('View Map', style: AppTypography.labelMedium.copyWith(color: AppColors.primary))),
                ],
              ).animate().fadeIn(delay: const Duration(milliseconds: 400)),
              
              const SizedBox(height: 16),
              
              _buildHighlight('08:00 AM', 'Coffee at Café Rivoire', 'The espresso here is divine...', Icons.coffee_rounded, AppColors.primary).animate().fadeIn(delay: const Duration(milliseconds: 600)),
              const SizedBox(height: 16),
              _buildHighlight('11:30 AM', 'Visit Uffizi Gallery', 'Renaissance masterpieces await...', Icons.museum_rounded, AppColors.secondary).animate().fadeIn(delay: const Duration(milliseconds: 800)),
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJourneyCard(Map<String, dynamic> j) {
    return GestureDetector(
      onTap: () => Get.to(() => const TripDetailsScreen()),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(j['image'] as String), fit: BoxFit.cover)),
                  child: Container(
                    decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)])),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(j['title'] as String, style: AppTypography.headlineMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold, height: 1.2)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(j['location'] as String, style: AppTypography.bodyMedium.copyWith(color: Colors.white)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                              child: Row(children: [const Icon(Icons.wb_sunny, color: Colors.white, size: 16), const SizedBox(width: 4), Text(j['temp'] as String, style: AppTypography.labelMedium.copyWith(color: Colors.white))]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Day ${j['day']} of ${j['total']}', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                      Text('${((j['progress'] as double) * 100).toInt()}%', style: AppTypography.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ]),
                    const SizedBox(height: 8),
                    ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(value: j['progress'] as double, backgroundColor: AppColors.grey200, valueColor: const AlwaysStoppedAnimation(AppColors.primary), minHeight: 8)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlight(String time, String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), child: Text(time, style: AppTypography.labelSmall.copyWith(color: color, fontWeight: FontWeight.bold))),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Expanded(child: Text(title, style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)))]),
            const SizedBox(height: 4),
            Text(desc, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
          ])),
          const Icon(Icons.chevron_right, color: AppColors.grey300),
        ],
      ),
    );
  }
}

class _ExplorePage extends StatelessWidget {
  const _ExplorePage();
  @override
  Widget build(BuildContext context) => Scaffold(backgroundColor: AppColors.grey50, body: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Explore New Places', style: AppTypography.headlineMedium.copyWith(fontWeight: FontWeight.bold)),
    const SizedBox(height: 24),
    Expanded(child: ListView(children: [
      _card('Santorini, Greece', 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=600'),
      _card('Bali, Indonesia', 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=600'),
      _card('Kyoto, Japan', 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=600'),
    ])),
  ]))));
  
  Widget _card(String name, String img) => GestureDetector(
    onTap: () => Get.to(() => const TripDetailsScreen()),
    child: Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15)]),
      child: Column(children: [
        ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), child: Image.network(img, height: 200, width: double.infinity, fit: BoxFit.cover)),
        Padding(padding: const EdgeInsets.all(20), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold)),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey300),
          ],
        )),
      ]),
    ),
  ).animate().fadeIn().slideY(begin: 0.1);
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Elegant Header with Background Blur/Gradient
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 32),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: AppTypography.headlineMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn().slideX(begin: -0.2),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.settings_outlined, color: Colors.white),
                      ).animate().fadeIn().rotate(begin: 0.5),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Profile Identity
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400'),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 14),
                          ).animate().scale(delay: 500.ms),
                        ],
                      ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                      const SizedBox(height: 16),
                      Text(
                        'Alex Thompson',
                        style: AppTypography.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 4),
                      Text(
                        'PRO TRAVELER • LEVEL 12',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.white70,
                          letterSpacing: 2,
                        ),
                      ).animate().fadeIn(delay: 400.ms),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Statistics Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('24', 'Trips'),
                  _buildStat('12', 'Countries'),
                  _buildStat('156', 'Memories'),
                ].animate(interval: 100.ms).fadeIn(delay: 600.ms).slideY(begin: 0.2),
              ),
            ),
          ),

          // Menu Options
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Account Settings',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ).animate().fadeIn(delay: 800.ms),
                const SizedBox(height: 16),
                _buildMenuItem(Icons.person_outline, 'Personal Information', 'Name, Email, Phone'),
                _buildMenuItem(Icons.payment_outlined, 'Payments & Payouts', 'History, Currency, Limits'),
                _buildMenuItem(Icons.notifications_active_outlined, 'Notifications', 'App sounds, Push alerts'),
                _buildMenuItem(Icons.security_outlined, 'Login & Security', 'Password, Biometrics'),
                
                const SizedBox(height: 32),
                Text(
                  'Support',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ).animate().fadeIn(delay: 1000.ms),
                const SizedBox(height: 16),
                _buildMenuItem(Icons.help_center_outlined, 'Help Center', 'FAQs, Contact support'),
                _buildMenuItem(Icons.info_outline, 'Terms of Service', 'Usage policy, Legal'),
                
                const SizedBox(height: 120), // Bottom padding for nav bar
              ].animate(interval: 100.ms).fadeIn(delay: 800.ms).slideX(begin: 0.1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(color: AppColors.grey500),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
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
        trailing: const Icon(Icons.chevron_right, color: AppColors.grey300),
        onTap: () {},
      ),
    );
  }
}
