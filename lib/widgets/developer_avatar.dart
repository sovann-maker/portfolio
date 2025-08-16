import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DeveloperAvatar extends StatefulWidget {
  final double size;
  final bool showGlow;

  const DeveloperAvatar({
    super.key,
    this.size = 280,
    this.showGlow = true,
  });

  @override
  State<DeveloperAvatar> createState() => _DeveloperAvatarState();
}

class _DeveloperAvatarState extends State<DeveloperAvatar>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _glowController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatingAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));
    
    _glowAnimation = Tween<double>(
      begin: 0.2,
      end: 0.4,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatingController, _glowController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  CustomColor.cyanAccent.withOpacity(0.8),
                  CustomColor.cyanAccent.withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: widget.showGlow ? [
                BoxShadow(
                  color: CustomColor.cyanAccent.withOpacity(_glowAnimation.value),
                  blurRadius: 40,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: CustomColor.cyanAccent.withOpacity(_glowAnimation.value * 0.5),
                  blurRadius: 80,
                  offset: const Offset(0, 20),
                ),
              ] : null,
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColor.scaffoldBg,
              ),
              child: CustomPaint(
                painter: EnhancedDeveloperAvatarPainter(
                  animationValue: _floatingController.value,
                ),
                size: Size(widget.size - 8, widget.size - 8),
              ),
            ),
          ),
        );
      },
    );
  }
}

class EnhancedDeveloperAvatarPainter extends CustomPainter {
  final double animationValue;
  
  EnhancedDeveloperAvatarPainter({required this.animationValue});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    paint.color = CustomColor.charcoal;
    canvas.drawCircle(center, radius - 10, paint);

    // Face
    paint.color = CustomColor.lightGray;
    canvas.drawCircle(
      Offset(center.dx, center.dy + 10),
      radius * 0.6,
      paint,
    );

    // Hair
    paint.color = CustomColor.darkGray;
    final hairPath = Path();
    hairPath.addOval(Rect.fromCenter(
      center: Offset(center.dx, center.dy - 20),
      width: radius * 1.1,
      height: radius * 0.8,
    ));
    canvas.drawPath(hairPath, paint);

    // Eyes
    paint.color = CustomColor.scaffoldBg;
    canvas.drawCircle(
      Offset(center.dx - 25, center.dy - 10),
      8,
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx + 25, center.dy - 10),
      8,
      paint,
    );

    // Eye pupils
    paint.color = CustomColor.cyanAccent;
    canvas.drawCircle(
      Offset(center.dx - 25, center.dy - 10),
      4,
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx + 25, center.dy - 10),
      4,
      paint,
    );

    // Glasses frame
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    paint.color = CustomColor.cyanAccent;
    
    // Left lens
    canvas.drawCircle(
      Offset(center.dx - 25, center.dy - 10),
      15,
      paint,
    );
    // Right lens
    canvas.drawCircle(
      Offset(center.dx + 25, center.dy - 10),
      15,
      paint,
    );
    // Bridge
    canvas.drawLine(
      Offset(center.dx - 10, center.dy - 10),
      Offset(center.dx + 10, center.dy - 10),
      paint,
    );

    // Smile
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = CustomColor.cyanAccent;
    final smilePath = Path();
    smilePath.addArc(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + 20),
        width: 40,
        height: 30,
      ),
      0,
      3.14159,
    );
    canvas.drawPath(smilePath, paint);

    // Hoodie
    paint.style = PaintingStyle.fill;
    paint.color = CustomColor.darkGray;
    final hoodieRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + radius * 0.7),
      width: radius * 1.4,
      height: radius * 0.8,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(hoodieRect, const Radius.circular(20)),
      paint,
    );

    // Hoodie strings
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = CustomColor.cyanAccent;
    canvas.drawLine(
      Offset(center.dx - 15, center.dy + 45),
      Offset(center.dx - 15, center.dy + 65),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx + 15, center.dy + 45),
      Offset(center.dx + 15, center.dy + 65),
      paint,
    );

    // Enhanced floating code symbols with animation
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // More diverse code symbols
    const symbols = ['</>', '{...}', 'fn()', '=>', 'const', 'async', '==', '++', 'npm', 'git'];
    final basePositions = [
      Offset(center.dx - 90, center.dy - 70),
      Offset(center.dx + 80, center.dy - 50),
      Offset(center.dx - 75, center.dy + 60),
      Offset(center.dx + 70, center.dy + 50),
      Offset(center.dx - 60, center.dy - 90),
      Offset(center.dx + 60, center.dy - 80),
      Offset(center.dx - 100, center.dy + 20),
      Offset(center.dx + 90, center.dy + 10),
      Offset(center.dx - 40, center.dy - 100),
      Offset(center.dx + 40, center.dy - 95),
    ];

    for (int i = 0; i < symbols.length; i++) {
      // Animate symbols with different phases
      final phase = (i / symbols.length) * 2 * 3.14159;
      final animatedOffset = Offset(
        basePositions[i].dx + (5 * (animationValue * 2 - 1) * (i % 2 == 0 ? 1 : -1)),
        basePositions[i].dy + (3 * (animationValue * 2 - 1) * (i % 3 == 0 ? 1 : -1)),
      );
      
      // Different opacities for depth effect
      final opacity = 0.3 + (0.4 * ((animationValue + phase / (2 * 3.14159)) % 1));
      
      textPainter.text = TextSpan(
        text: symbols[i],
        style: TextStyle(
          color: CustomColor.cyanAccent.withOpacity(opacity),
          fontSize: 12 + (2 * opacity),
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, animatedOffset);
    }
    
    // Add laptop/coding elements
    paint.style = PaintingStyle.fill;
    paint.color = CustomColor.darkGray;
    
    // Laptop screen
    final laptopRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + radius * 0.9),
      width: 40,
      height: 25,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(laptopRect, const Radius.circular(3)),
      paint,
    );
    
    // Screen glow
    paint.color = CustomColor.cyanAccent.withOpacity(0.3);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        laptopRect.deflate(2),
        const Radius.circular(2),
      ),
      paint,
    );
    
    // Terminal lines on screen
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = CustomColor.cyanAccent;
    for (int i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(laptopRect.left + 4, laptopRect.top + 6 + (i * 4)),
        Offset(laptopRect.right - 4, laptopRect.top + 6 + (i * 4)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! EnhancedDeveloperAvatarPainter || 
           oldDelegate.animationValue != animationValue;
  }
}