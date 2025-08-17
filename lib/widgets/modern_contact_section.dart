import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import 'modern_button.dart';
import 'code_section_header.dart';
import 'package:url_launcher/url_launcher.dart';

class ModernContactSection extends StatefulWidget {
  const ModernContactSection({super.key});

  @override
  State<ModernContactSection> createState() => _ModernContactSectionState();
}

class _ModernContactSectionState extends State<ModernContactSection>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Contact methods
  void _openEmail() async {
    final Uri emailUrl = Uri.parse('mailto:chimsovann7060@gmail.com?subject=Portfolio Inquiry');
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    }
  }

  void _copyEmail() {
    Clipboard.setData(const ClipboardData(text: 'chimsovann7060@gmail.com'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: CustomColor.cyanAccent),
            const SizedBox(width: 8),
            const Text('Email copied to clipboard!'),
          ],
        ),
        backgroundColor: CustomColor.surfaceColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    _animationController.forward();

    // Simulate form submission
    await Future.delayed(const Duration(seconds: 2));

    // Here you would integrate with your backend API or email service
    // For now, we'll just show a success message and open email client

    final name = _nameController.text;
    final email = _emailController.text;
    final message = _messageController.text;

    final emailBody =
        Uri.encodeComponent('From: $name ($email)\n\nMessage:\n$message');

    final Uri emailUrl = Uri.parse('mailto:chimsovann7060@gmail.com?subject=Portfolio Contact from $name&body=$emailBody');
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    }

    setState(() => _isSubmitting = false);
    _animationController.reverse();

    // Clear form
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.rocket_launch, color: CustomColor.cyanAccent),
              const SizedBox(width: 8),
              const Text('Message sent! Opening email client...'),
            ],
          ),
          backgroundColor: CustomColor.surfaceColor,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          // Quick Contact Options
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColor.surfaceColor.withOpacity(0.3),
                  CustomColor.charcoal.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: CustomColor.borderColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                    children: [
                      const TextSpan(
                        text: 'const ',
                        style: TextStyle(color: CustomColor.cyanAccent),
                      ),
                      const TextSpan(
                        text: 'email ',
                        style: TextStyle(color: CustomColor.textPrimary),
                      ),
                      const TextSpan(
                        text: '= "',
                        style: TextStyle(color: CustomColor.cyanAccent),
                      ),
                      const TextSpan(
                        text: 'chimsovann7060@gmail.com',
                        style: TextStyle(color: CustomColor.textSecondary),
                      ),
                      const TextSpan(
                        text: '";',
                        style: TextStyle(color: CustomColor.cyanAccent),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Email Action Button
                Center(
                  child: _buildEmailCard(),
                ),

                const SizedBox(height: 24),

                const SizedBox(height: 24),

                // Copy email button
                GestureDetector(
                  onTap: _copyEmail,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColor.cyanAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: CustomColor.cyanAccent.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.copy_rounded,
                          color: CustomColor.cyanAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Copy Email',
                          style: TextStyle(
                            color: CustomColor.cyanAccent,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildEmailCard() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openEmail,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomColor.cyanAccent.withOpacity(0.2),
                CustomColor.surfaceColor.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: CustomColor.cyanAccent.withOpacity(0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColor.cyanAccent.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.email_outlined,
                color: CustomColor.cyanAccent,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'sendEmail()',
                style: TextStyle(
                  color: CustomColor.textPrimary,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Click to open email client',
                style: TextStyle(
                  color: CustomColor.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    String method,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 140,
          height: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomColor.surfaceColor.withOpacity(0.5),
                CustomColor.charcoal.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CustomColor.borderColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: CustomColor.cyanAccent,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                method,
                style: TextStyle(
                  color: CustomColor.textPrimary,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: CustomColor.textMuted,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontFamily: 'monospace'),
            children: [
              const TextSpan(
                text: 'const ',
                style: TextStyle(color: CustomColor.cyanAccent),
              ),
              TextSpan(
                text: label.toLowerCase(),
                style: const TextStyle(color: CustomColor.textSecondary),
              ),
              const TextSpan(
                text: ' = ',
                style: TextStyle(color: CustomColor.cyanAccent),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            color: CustomColor.textPrimary,
            fontFamily: 'monospace',
          ),
          decoration: InputDecoration(
            hintText: '"Enter your ${label.toLowerCase()}"',
            hintStyle: TextStyle(
              color: CustomColor.textMuted,
              fontFamily: 'monospace',
            ),
            filled: true,
            fillColor: CustomColor.charcoal.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: CustomColor.borderColor.withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: CustomColor.borderColor.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: CustomColor.cyanAccent.withOpacity(0.5),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (label.toLowerCase() == 'email' && !value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      ],
    );
  }
}
