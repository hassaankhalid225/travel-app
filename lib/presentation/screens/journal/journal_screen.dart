import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class JournalController extends GetxController {
  final journalEntries = [
    {
      'date': 'Oct 15, 2023',
      'title': 'Morning in Florence',
      'content': 'The light hitting the Duomo this morning was something I\'ll never forget. The marble glowed in shades of pink and gold...',
      'image': 'https://images.unsplash.com/photo-1541085388133-27083070cd2b?w=400',
      'location': 'Florence, Italy',
      'type': 'Voice Note'
    },
    {
      'date': 'Oct 14, 2023',
      'title': 'Tuscan Wine Tasting',
      'content': 'Spent the afternoon at a family-owned vineyard in Chianti. The passion they have for their craft is evident in every sip.',
      'image': 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=400',
      'location': 'Chianti, Italy',
      'type': 'Photo Story'
    },
    {
      'date': 'Oct 12, 2023',
      'title': 'Arrived in Siena',
      'content': 'The medieval architecture here is incredibly well-preserved. Walking through the Piazza del Campo felt like stepping back in time.',
      'image': 'https://images.unsplash.com/photo-1520106212299-d99c443e4568?w=400',
      'location': 'Siena, Italy',
      'type': 'Journal Entry'
    },
  ].obs;
}

class JournalScreen extends GetView<JournalController> {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<JournalController>()) {
      Get.put(JournalController());
    }

    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            backgroundColor: AppColors.grey50,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: Text(
                'Travel Journal',
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: AppColors.textPrimary),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 12),
            ],
          ),
          
          Obx(() => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final entry = controller.journalEntries[index];
                return _buildJournalCard(entry, index);
              },
              childCount: controller.journalEntries.length,
            ),
          )),
          
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildJournalCard(Map<String, String> entry, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entry['image'] != null)
                Image.network(
                  entry['image']!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            entry['type']!,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          entry['date']!,
                          style: AppTypography.labelSmall.copyWith(color: AppColors.grey500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      entry['title']!,
                      style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: AppColors.grey400),
                        const SizedBox(width: 4),
                        Text(
                          entry['location']!,
                          style: AppTypography.labelSmall.copyWith(color: AppColors.grey400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      entry['content']!,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary, height: 1.5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1),
    );
  }
}
