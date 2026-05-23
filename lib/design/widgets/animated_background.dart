import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Orb> _orbs = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Initialize random orbs
    for (int i = 0; i < 4; i++) {
      _orbs.add(Orb(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        radius: 150 + _random.nextDouble() * 200,
        color: _getRandomColor(),
        speedX: (_random.nextDouble() - 0.5) * 0.5,
        speedY: (_random.nextDouble() - 0.5) * 0.5,
      ));
    }
  }

  Color _getRandomColor() {
    List<Color> colors = [
      AppColors.purple.withValues(alpha: 0.15),
      AppColors.purpleDark.withValues(alpha: 0.15),
      AppColors.violet.withValues(alpha: 0.10),
    ];
    return colors[_random.nextInt(colors.length)];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: AmbientOrbsPainter(_orbs, _controller.value),
              );
            },
          ),
        ),
        // A subtle noise overlay or grid can be added here if needed
        widget.child,
      ],
    );
  }
}

class Orb {
  double x, y;
  double radius;
  Color color;
  double speedX, speedY;

  Orb({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
    required this.speedX,
    required this.speedY,
  });
}

class AmbientOrbsPainter extends CustomPainter {
  final List<Orb> orbs;
  final double progress;

  AmbientOrbsPainter(this.orbs, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (var orb in orbs) {
      // Calculate continuous floating movement using sine waves based on progress
      double dx = orb.x * size.width + sin(progress * pi * 2 + orb.speedX * 10) * 100;
      double dy = orb.y * size.height + cos(progress * pi * 2 + orb.speedY * 10) * 100;

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            orb.color,
            orb.color.withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(dx, dy), radius: orb.radius))
        ..blendMode = BlendMode.screen;

      canvas.drawCircle(Offset(dx, dy), orb.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant AmbientOrbsPainter oldDelegate) => true;
}
