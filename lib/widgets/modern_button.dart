import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isGradient;
  final double? width;
  final IconData? icon;
  final bool isOutlined;

  const ModernButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isGradient = true,
    this.width,
    this.icon,
    this.isOutlined = false,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
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
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) => _animationController.reverse(),
        onTapCancel: () => _animationController.reverse(),
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: widget.width,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: widget.isOutlined
                      ? null
                      : (widget.isGradient
                          ? CustomColor.primaryGradient
                          : LinearGradient(
                              colors: [
                                CustomColor.primaryGray,
                                CustomColor.primaryGray,
                              ],
                            )),
                  color: widget.isOutlined ? Colors.transparent : null,
                  borderRadius: BorderRadius.circular(30),
                  border: widget.isOutlined
                      ? Border.all(
                          color: _isHovered
                              ? CustomColor.textPrimary
                              : CustomColor.textSecondary,
                          width: 2,
                        )
                      : null,
                  boxShadow: widget.isOutlined
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: _isHovered ? 20 : 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        color: widget.isOutlined
                            ? (_isHovered
                                ? CustomColor.cyanAccent
                                : CustomColor.textSecondary)
                            : (widget.isGradient
                                ? CustomColor.scaffoldBg
                                : CustomColor.textPrimary),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: widget.isOutlined
                            ? (_isHovered
                                ? CustomColor.cyanAccent
                                : CustomColor.textSecondary)
                            : (widget.isGradient
                                ? CustomColor.scaffoldBg
                                : CustomColor.textPrimary),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}