import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CodeSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showLineNumbers;

  const CodeSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showLineNumbers = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Code-style header
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showLineNumbers) ...[
              // Line numbers
              Container(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    Text(
                      '01',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: CustomColor.textMuted,
                        fontFamily: 'monospace',
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        '02',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: CustomColor.textMuted,
                          fontFamily: 'monospace',
                        ),
                      ),
                  ],
                ),
              ),
              // Vertical line
              Container(
                width: 1,
                height: subtitle != null ? 60 : 30,
                color: CustomColor.borderColor,
                margin: const EdgeInsets.only(right: 24),
              ),
            ],
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main title with code syntax
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: '< ',
                          style: TextStyle(color: CustomColor.cyanAccent),
                        ),
                        TextSpan(
                          text: title,
                          style: const TextStyle(color: CustomColor.textPrimary),
                        ),
                        TextSpan(
                          text: ' />',
                          style: TextStyle(color: CustomColor.cyanAccent),
                        ),
                      ],
                    ),
                  ),
                  
                  if (subtitle != null) ...[
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontFamily: 'monospace',
                        ),
                        children: [
                          TextSpan(
                            text: '// ',
                            style: TextStyle(color: CustomColor.textMuted),
                          ),
                          TextSpan(
                            text: subtitle,
                            style: const TextStyle(color: CustomColor.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 32),
        
        // Animated underline
        Container(
          height: 2,
          width: 60,
          decoration: BoxDecoration(
            gradient: CustomColor.primaryGradient,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }
}

class AnimatedCodeHeader extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Duration delay;

  const AnimatedCodeHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedCodeHeader> createState() => _AnimatedCodeHeaderState();
}

class _AnimatedCodeHeaderState extends State<AnimatedCodeHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: CodeSectionHeader(
              title: widget.title,
              subtitle: widget.subtitle,
            ),
          ),
        );
      },
    );
  }
}