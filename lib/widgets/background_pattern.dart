import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BackgroundPattern extends StatelessWidget {
  final Widget child;

  const BackgroundPattern({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColor.scaffoldBg,
            CustomColor.bgLight1,
            CustomColor.scaffoldBg,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Grid pattern
          CustomPaint(
            painter: GridPatternPainter(),
            size: Size.infinite,
          ),
          // Floating code elements
          Positioned.fill(
            child: CustomPaint(
              painter: FloatingCodePainter(),
            ),
          ),
          // Main content
          child,
        ],
      ),
    );
  }
}

class GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CustomColor.borderColor.withOpacity(0.1)
      ..strokeWidth = 1;

    const spacing = 50.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FloatingCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Code symbols and their positions
    final symbols = [
      {'text': '{', 'x': size.width * 0.1, 'y': size.height * 0.2},
      {'text': '}', 'x': size.width * 0.9, 'y': size.height * 0.8},
      {'text': '</', 'x': size.width * 0.85, 'y': size.height * 0.15},
      {'text': '/>', 'x': size.width * 0.15, 'y': size.height * 0.85},
      {'text': '()', 'x': size.width * 0.8, 'y': size.height * 0.3},
      {'text': '[]', 'x': size.width * 0.2, 'y': size.height * 0.7},
      {'text': '=>', 'x': size.width * 0.75, 'y': size.height * 0.6},
      {'text': '&&', 'x': size.width * 0.25, 'y': size.height * 0.4},
      {'text': '||', 'x': size.width * 0.7, 'y': size.height * 0.9},
      {'text': '++', 'x': size.width * 0.3, 'y': size.height * 0.1},
    ];

    for (final symbol in symbols) {
      textPainter.text = TextSpan(
        text: symbol['text'] as String,
        style: TextStyle(
          color: CustomColor.cyanAccent.withOpacity(0.1),
          fontSize: 24,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(symbol['x'] as double, symbol['y'] as double),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AnimatedBackgroundPattern extends StatefulWidget {
  final Widget child;

  const AnimatedBackgroundPattern({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBackgroundPattern> createState() => _AnimatedBackgroundPatternState();
}

class _AnimatedBackgroundPatternState extends State<AnimatedBackgroundPattern>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CustomColor.scaffoldBg,
            CustomColor.bgLight1,
            CustomColor.scaffoldBg,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated floating particles
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: FloatingParticlesPainter(_animation.value),
                size: Size.infinite,
              );
            },
          ),
          widget.child,
        ],
      ),
    );
  }
}

class FloatingParticlesPainter extends CustomPainter {
  final double animationValue;

  FloatingParticlesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CustomColor.cyanAccent.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Create floating particles
    for (int i = 0; i < 8; i++) {
      final x = (size.width * 0.1 * i + animationValue * 100) % size.width;
      final y = (size.height * 0.2 * i + animationValue * 50) % size.height;
      
      canvas.drawCircle(
        Offset(x, y),
        2 + (i % 3),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}