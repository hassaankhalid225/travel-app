import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../map/route_tracking_screen.dart';

class TripDetailsController extends GetxController {}

class TripDetailsScreen extends GetView<TripDetailsController> {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      body: CustomScrollView(
        slivers: [
          // Hero Header
          SliverAppBar(
            expandedHeight: 450,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.ios_share_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=800',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'TRIP COMPLETED',
                            style: AppTypography.labelSmall.copyWith(color: Colors.white, letterSpacing: 1),
                          ),
                        ).animate().fadeIn().slideY(begin: 0.5),
                        const SizedBox(height: 12),
                        Text(
                          'The Tuscan\nEscape',
                          style: AppTypography.headlineLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ).animate().fadeIn(delay: const Duration(milliseconds: 200)).slideY(begin: 0.5),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                            const SizedBox(width: 8),
                            Text(
                              'Oct 12 - Oct 20, 2023',
                              style: AppTypography.labelSmall.copyWith(color: Colors.white70),
                            ),
                          ],
                        ).animate().fadeIn(delay: const Duration(milliseconds: 400)).slideY(begin: 0.5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The Story
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'The Story',
                        style: AppTypography.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.auto_awesome, color: AppColors.primary, size: 20),
                    ],
                  ).animate().fadeIn(delay: const Duration(milliseconds: 600)),
                  const SizedBox(height: 16),
                  Text(
                    'Your journey began in the rolling hills of Chianti, where the golden hour painted the vineyards in amber hues. From the quiet cobblestone streets of Siena to the bustling markets of Florence, every mile told a story of exploration...',
                    style: AppTypography.bodyMedium.copyWith(color: Colors.white70, height: 1.6),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 800)),
                  
                  const SizedBox(height: 48),

                  // Top Highlights
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Highlights',
                        style: AppTypography.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Swipe to view',
                        style: AppTypography.labelSmall.copyWith(color: Colors.white30),
                      ),
                    ],
                  ).animate().fadeIn(delay: const Duration(seconds: 1)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildHighlightCard('Siena Sunset', 'https://images.unsplash.com/photo-1520106212299-d99c443e4568?w=400'),
                        _buildHighlightCard('Pasta Class', 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=400'),
                        _buildHighlightCard('Uffizi Morning', 'https://images.unsplash.com/photo-1565011523534-4bc5f1595eb5?w=400'),
                      ],
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 1200)).slideX(begin: 0.1),

                  const SizedBox(height: 48),

                  // Trip Stats
                  Text(
                    'Trip Stats',
                    style: AppTypography.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 1400)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatBox(Icons.photo_library_rounded, '142', 'PHOTOS', const Color(0xFF6366F1)),
                      _buildStatBox(Icons.location_on_rounded, '3', 'CITIES', const Color(0xFFF59E0B)),
                      _buildStatBox(Icons.mic_rounded, '5', 'NOTES', const Color(0xFF10B981)),
                    ],
                  ).animate().fadeIn(delay: const Duration(milliseconds: 1600)).slideY(begin: 0.2),

                  const SizedBox(height: 48),

                  GestureDetector(
                    onTap: () => Get.to(() => const RouteTrackingScreen()),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1524661135-423995f22d0b?w=800'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.map_rounded, color: AppColors.primary),
                                const SizedBox(width: 8),
                                Text(
                                  'View Route',
                                  style: AppTypography.buttonLarge.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 1800)).scale(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(String title, String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
          ),
        ),
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: AppTypography.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStatBox(IconData icon, String value, String label, Color color) {
    return Container(
      width: (Get.width - 64) / 3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTypography.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: Colors.white30, fontSize: 9),
          ),
        ],
      ),
    );
  }
}
