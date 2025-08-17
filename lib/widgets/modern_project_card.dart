import 'package:flutter/material.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';

class ModernProjectCard extends StatefulWidget {
  final ProjectUtils project;
  final Map<String, String> techStack;

  const ModernProjectCard({
    super.key,
    required this.project,
    required this.techStack,
  });

  @override
  State<ModernProjectCard> createState() => _ModernProjectCardState();
}

class _ModernProjectCardState extends State<ModernProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _openProject() async {
    if (widget.project.webLink != null) {
      final Uri url = Uri.parse(widget.project.webLink!);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openProject,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        CustomColor.surfaceColor.withOpacity(0.8),
                        CustomColor.charcoal.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isHovered
                          ? CustomColor.cyanAccent.withOpacity(0.5)
                          : CustomColor.borderColor.withOpacity(0.3),
                      width: _isHovered ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: _isHovered ? 25 : 10,
                        offset: Offset(0, _isHovered ? 15 : 5),
                      ),
                      if (_isHovered)
                        BoxShadow(
                          color: CustomColor.cyanAccent.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Image with overlay
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(widget.project.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              
                              // Gradient overlay
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      CustomColor.scaffoldBg.withOpacity(0.8),
                                    ],
                                  ),
                                ),
                              ),

                              // Tech stack badges
                              if (widget.techStack.isNotEmpty)
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  right: 12,
                                  child: Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: widget.techStack.entries.take(3).map((entry) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: CustomColor.cyanAccent.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          entry.key,
                                          style: const TextStyle(
                                            color: CustomColor.scaffoldBg,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),

                              // Hover overlay with action
                              if (_isHovered)
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        CustomColor.cyanAccent.withOpacity(0.1),
                                        CustomColor.scaffoldBg.withOpacity(0.9),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: CustomColor.cyanAccent,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.launch,
                                            color: CustomColor.scaffoldBg,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'View Project',
                                            style: TextStyle(
                                              color: CustomColor.scaffoldBg,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Project details
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Project title
                                Text(
                                  widget.project.title,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: CustomColor.textPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'monospace',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                const SizedBox(height: 12),
                                
                                // Project description
                                Expanded(
                                  child: Text(
                                    widget.project.subtitle,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: CustomColor.textSecondary,
                                      height: 1.5,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Action row
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: CustomColor.cyanAccent.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: CustomColor.cyanAccent.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.code,
                                            color: CustomColor.cyanAccent,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'View Code',
                                            style: TextStyle(
                                              color: CustomColor.cyanAccent,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'monospace',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    const Spacer(),
                                    
                                    // Project links
                                    if (widget.project.webLink != null)
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: CustomColor.surfaceColor,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: CustomColor.borderColor,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.language,
                                          color: CustomColor.cyanAccent,
                                          size: 16,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}