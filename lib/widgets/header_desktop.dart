import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/site_logo.dart';

import '../constants/colors.dart';
import '../constants/nav_items.dart';

class HeaderDesktop extends StatefulWidget {
  const HeaderDesktop({
    super.key,
    required this.onNavMenuTap,
  });
  final Function(int) onNavMenuTap;

  @override
  State<HeaderDesktop> createState() => _HeaderDesktopState();
}

class _HeaderDesktopState extends State<HeaderDesktop> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 40.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: CustomColor.surfaceColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CustomColor.borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo with code style
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => widget.onNavMenuTap(0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    TextSpan(
                      text: '<',
                      style: TextStyle(color: CustomColor.cyanAccent),
                    ),
                    const TextSpan(
                      text: 'Sovann',
                      style: TextStyle(color: CustomColor.textPrimary),
                    ),
                    TextSpan(
                      text: ' />',
                      style: TextStyle(color: CustomColor.cyanAccent),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          
          // Navigation items
          Row(
            children: [
              for (int i = 0; i < navTitles.length; i++)
                _buildNavItem(i, navTitles[i]),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(int index, String title) {
    final isHovered = _hoveredIndex == index;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onNavMenuTap(index),
        child: Container(
          margin: const EdgeInsets.only(left: 32),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isHovered 
                ? CustomColor.cyanAccent.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHovered 
                  ? CustomColor.cyanAccent.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: '.',
                  style: TextStyle(
                    color: isHovered 
                        ? CustomColor.cyanAccent 
                        : CustomColor.textMuted,
                  ),
                ),
                TextSpan(
                  text: title.toLowerCase(),
                  style: TextStyle(
                    color: isHovered 
                        ? CustomColor.cyanAccent 
                        : CustomColor.textSecondary,
                  ),
                ),
                TextSpan(
                  text: '()',
                  style: TextStyle(
                    color: isHovered 
                        ? CustomColor.cyanAccent 
                        : CustomColor.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
