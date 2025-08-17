import 'package:flutter/material.dart';
import 'package:my_portfolio/utils/project_utils.dart';

import '../constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCardWidget extends StatefulWidget {
  const ProjectCardWidget({
    super.key,
    required this.project,
  });
  final ProjectUtils project;

  @override
  State<ProjectCardWidget> createState() => _ProjectCardWidgetState();
}

class _ProjectCardWidgetState extends State<ProjectCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.03,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
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
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              height: 320,
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isHovered
                      ? CustomColor.textPrimary.withOpacity(0.3)
                      : CustomColor.borderColor,
                  width: 1,
                ),
                gradient: CustomColor.cardGradient,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 2),
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project image with overlay
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          widget.project.image,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Content section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title with code style
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace',
                              ),
                              children: [
                                const TextSpan(
                                  text: 'project: "',
                                  style: TextStyle(color: CustomColor.textMuted),
                                ),
                                TextSpan(
                                  text: widget.project.title,
                                  style: const TextStyle(color: CustomColor.textPrimary),
                                ),
                                const TextSpan(
                                  text: '"',
                                  style: TextStyle(color: CustomColor.textMuted),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          
                          // Subtitle/Description
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
                          
                          // Action buttons
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColor.cyanAccent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: CustomColor.cyanAccent.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  'demo()',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: CustomColor.cyanAccent,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              
                              // Platform icons
                              Row(
                                children: [
                                  if (widget.project.iosLink != null)
                                    _buildPlatformIcon(
                                      'assets/ios_icon.png',
                                      () async {
                                        final Uri url = Uri.parse(widget.project.iosLink!);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        }
                                      },
                                    ),
                                  if (widget.project.androidLink != null)
                                    _buildPlatformIcon(
                                      'assets/android_icon.png',
                                      () async {
                                        final Uri url = Uri.parse(widget.project.androidLink!);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        }
                                      },
                                    ),
                                  if (widget.project.webLink != null)
                                    _buildPlatformIcon(
                                      'assets/web_icon.png',
                                      () async {
                                        final Uri url = Uri.parse(widget.project.webLink!);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        }
                                      },
                                    ),
                                ],
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
          );
        },
      ),
    );
  }
  
  Widget _buildPlatformIcon(String assetPath, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CustomColor.surfaceColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CustomColor.borderColor,
            ),
          ),
          child: Image.asset(
            assetPath,
            width: 16,
            height: 16,
          ),
        ),
      ),
    );
  }
}
