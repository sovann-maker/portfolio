import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';
import 'animated_section.dart';
import 'modern_button.dart';
import 'developer_avatar.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Developer Avatar
          const AnimatedSection(
            delay: Duration(milliseconds: 300),
            child: DeveloperAvatar(
              size: 240,
              showGlow: true,
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Text content
          AnimatedSection(
            delay: const Duration(milliseconds: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Code-style intro
                Text(
                  'const developer = {',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: CustomColor.cyanAccent,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                
                // Name with code syntax
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1.0,
                    ),
                    children: [
                      const TextSpan(
                        text: 'name: "',
                        style: TextStyle(
                          color: CustomColor.textSecondary,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: 'Sovann Chim',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = CustomColor.cyanGradient.createShader(
                              const Rect.fromLTWH(0, 0, 200, 50),
                            ),
                        ),
                      ),
                      const TextSpan(
                        text: '"',
                        style: TextStyle(
                          color: CustomColor.textSecondary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                
                // Role
                Text(
                  'role: "Software Engineer"',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: CustomColor.cyanAccent,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                // Closing bracket
                Text(
                  '};',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: CustomColor.textPrimary,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                
                // Description with comment style
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '/* Building digital experiences with\n   clean code and intuitive design */',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: CustomColor.textSecondary,
                      height: 1.6,
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                
                // CTA Buttons
                Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: ModernButton(
                        text: 'contact()',
                        onPressed: () async {
                          final Uri emailUrl = Uri.parse('mailto:chimsovann7060@gmail.com?subject=Portfolio Inquiry');
                          if (await canLaunchUrl(emailUrl)) {
                            await launchUrl(emailUrl);
                          }
                        },
                        icon: Icons.terminal,
                        isGradient: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: ModernButton(
                        text: 'viewProjects()',
                        onPressed: () {},
                        icon: Icons.code,
                        isOutlined: true,
                      ),
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
}