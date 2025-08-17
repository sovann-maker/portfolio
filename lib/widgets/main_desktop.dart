import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';
import 'animated_section.dart';
import 'glassmorphic_container.dart';
import 'modern_button.dart';
import 'developer_avatar.dart';

class MainDesktop extends StatefulWidget {
  final VoidCallback? onScrollToProjects;
  
  const MainDesktop({super.key, this.onScrollToProjects});
  
  @override
  State<MainDesktop> createState() => _MainDesktopState();
}

class _MainDesktopState extends State<MainDesktop> {
  void _scrollToProjects() {
    // Call the callback provided by parent widget
    widget.onScrollToProjects?.call();
  }
  
  void _downloadCV() async {
    // Download CV functionality
    final Uri url = Uri.parse('/assets/Sovann\'s%20Resume..pdf');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40.0),
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      constraints: BoxConstraints(
        minHeight: screenHeight * 0.8,
        maxWidth: 1400,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side - Text content
          Expanded(
            flex: 3,
            child: AnimatedSection(
              delay: const Duration(milliseconds: 300),
              offset: const Offset(-50, 0),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      CustomColor.surfaceColor.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: CustomColor.borderColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  // Enhanced code-style greeting with line numbers
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: CustomColor.scaffoldBg.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: CustomColor.borderColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Code header
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'portfolio.js',
                              style: TextStyle(
                                color: CustomColor.textSecondary,
                                fontSize: 12,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Code with line numbers
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontFamily: 'monospace',
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: '1  ',
                                style: TextStyle(
                                  color: CustomColor.textMuted,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'const ',
                                style: TextStyle(color: CustomColor.cyanAccent),
                              ),
                              TextSpan(
                                text: 'developer ',
                                style: TextStyle(color: Colors.orange[300]),
                              ),
                              TextSpan(
                                text: '= ',
                                style: TextStyle(color: CustomColor.cyanAccent),
                              ),
                              const TextSpan(
                                text: '{',
                                style: TextStyle(color: CustomColor.textPrimary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Enhanced name and role in code container
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name line
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontFamily: 'monospace',
                              height: 1.3,
                            ),
                            children: [
                              TextSpan(
                                text: '2  ',
                                style: TextStyle(
                                  color: CustomColor.textMuted,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: '  name: ',
                                style: TextStyle(
                                  color: Colors.purple[300],
                                  fontSize: 18,
                                ),
                              ),
                              const TextSpan(
                                text: '"',
                                style: TextStyle(
                                  color: CustomColor.textSecondary,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: 'Sovann Chim',
                                style: TextStyle(
                                  color: Colors.green[300],
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(
                                text: '",',
                                style: TextStyle(
                                  color: CustomColor.textSecondary,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Role line
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontFamily: 'monospace',
                              height: 1.3,
                            ),
                            children: [
                              TextSpan(
                                text: '3  ',
                                style: TextStyle(
                                  color: CustomColor.textMuted,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: '  role: ',
                                style: TextStyle(
                                  color: Colors.purple[300],
                                ),
                              ),
                              const TextSpan(
                                text: '"',
                                style: TextStyle(color: CustomColor.textSecondary),
                              ),
                              TextSpan(
                                text: 'Junior Software Engineer',
                                style: TextStyle(color: Colors.green[300]),
                              ),
                              const TextSpan(
                                text: '",',
                                style: TextStyle(color: CustomColor.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        
                        // Closing line
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontFamily: 'monospace',
                            ),
                            children: [
                              TextSpan(
                                text: '4  ',
                                style: TextStyle(
                                  color: CustomColor.textMuted,
                                  fontSize: 14,
                                ),
                              ),
                              const TextSpan(
                                text: '};',
                                style: TextStyle(
                                  color: CustomColor.textPrimary,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Enhanced description with comment block
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(20),
                    constraints: const BoxConstraints(maxWidth: 520),
                    decoration: BoxDecoration(
                      color: CustomColor.scaffoldBg.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: CustomColor.borderColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          fontFamily: 'monospace',
                        ),
                        children: [
                          TextSpan(
                            text: '/**\n',
                            style: TextStyle(
                              color: CustomColor.textMuted,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: ' * Junior Software Engineer passionate about\n',
                            style: TextStyle(
                              color: CustomColor.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: ' * building scalable applications and solving\n',
                            style: TextStyle(
                              color: CustomColor.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: ' * complex problems through clean code.\n',
                            style: TextStyle(
                              color: CustomColor.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: ' * \n',
                            style: TextStyle(
                              color: CustomColor.textMuted,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: ' * @author Sovann Chim\n',
                            style: TextStyle(
                              color: Colors.orange[300],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: ' * @version 2.0.0\n',
                            style: TextStyle(
                              color: Colors.orange[300],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: ' * @since 2022\n',
                            style: TextStyle(
                              color: Colors.orange[300],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: ' */',
                            style: TextStyle(
                              color: CustomColor.textMuted,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Enhanced CTA Buttons with better spacing
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        ModernButton(
                          text: 'developer.contact()',
                          onPressed: () async {
                            final Uri emailUrl = Uri.parse('mailto:chimsovann7060@gmail.com?subject=Portfolio Inquiry&body=Hi Sovann, I would like to discuss a project opportunity.');
                            if (await canLaunchUrl(emailUrl)) {
                              await launchUrl(emailUrl);
                            }
                          },
                          icon: Icons.email_outlined,
                          isGradient: true,
                        ),
                        ModernButton(
                          text: 'viewProjects()',
                          onPressed: _scrollToProjects,
                          icon: Icons.code,
                          isOutlined: true,
                        ),
                        ModernButton(
                          text: 'downloadCV()',
                          onPressed: _downloadCV,
                          icon: Icons.download,
                          isOutlined: true,
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 80),
          
          // Right side - Developer Avatar
          Expanded(
            flex: 2,
            child: AnimatedSection(
              delay: const Duration(milliseconds: 600),
              offset: const Offset(50, 0),
              child: const Center(
                child: DeveloperAvatar(
                  size: 320,
                  showGlow: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
