import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/skill_items.dart';
import 'animated_section.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSection(
      delay: const Duration(milliseconds: 200),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Platforms section
            Text(
              'Platforms & Tools',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: CustomColor.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            
            StaggeredAnimationWidget(
              children: [
                for (int i = 0; i < platformItems.length; i++)
                  _buildPlatformCard(context, platformItems[i]),
              ],
            ),
            
            const SizedBox(height: 40),

            // Skills section
            Text(
              'Technologies & Skills',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: CustomColor.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            
            AnimatedSection(
              delay: const Duration(milliseconds: 400),
              child: Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < skillItems.length; i++)
                    _buildSkillChip(context, skillItems[i]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPlatformCard(BuildContext context, Map<String, dynamic> platform) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CustomColor.lightGray.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              platform['img'],
              width: 20,
              height: 20,
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
        horizontal: 14,
        vertical: 10,
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
        borderRadius: BorderRadius.circular(6),
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
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 8),
          Text(
            skill['title'],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
