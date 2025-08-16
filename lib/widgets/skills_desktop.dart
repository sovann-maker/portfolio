import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/skill_items.dart';
import 'animated_section.dart';

class SkillsDesktop extends StatelessWidget {
  const SkillsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSection(
      delay: const Duration(milliseconds: 200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Platforms section
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platforms & Tools',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: CustomColor.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                StaggeredAnimationWidget(
                  staggerDelay: const Duration(milliseconds: 100),
                  children: [
                    for (int i = 0; i < platformItems.length; i++)
                      _buildPlatformCard(context, platformItems[i]),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 60),

          // Skills section
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Technologies & Skills',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: CustomColor.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                StaggeredAnimationWidget(
                  direction: Axis.horizontal,
                  children: [
                    Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: [
                        for (int i = 0; i < skillItems.length; i++)
                          _buildSkillChip(context, skillItems[i]),
                      ],
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
  
  Widget _buildPlatformCard(BuildContext context, Map<String, dynamic> platform) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: CustomColor.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CustomColor.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CustomColor.lightGray.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              platform['img'],
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              platform['title'],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: CustomColor.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSkillChip(BuildContext context, Map<String, dynamic> skill) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColor.cyanAccent.withOpacity(0.1),
            CustomColor.charcoal.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CustomColor.cyanAccent.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            skill['img'],
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 10),
          Text(
            skill['title'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: CustomColor.textPrimary,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
