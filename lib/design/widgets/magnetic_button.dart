import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MagneticButton extends StatefulWidget {
  final Widget child;
  final double magneticStrength;

  const MagneticButton({
    super.key,
    required this.child,
    this.magneticStrength = 0.2, // 20% of distance
  });

  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton> with SingleTickerProviderStateMixin {
  double _x = 0;
  double _y = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent details) {
    if (!mounted) return;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Size size = box.size;
    final Offset localPosition = box.globalToLocal(details.position);

    // Calculate distance from center
    final double dx = localPosition.dx - (size.width / 2);
    final double dy = localPosition.dy - (size.height / 2);

    setState(() {
      _x = dx * widget.magneticStrength;
      _y = dy * widget.magneticStrength;
      if (!_isHovered) {
        _isHovered = true;
        _controller.forward();
      }
    });
  }

  void _onExit(PointerExitEvent details) {
    if (!mounted) return;
    setState(() {
      _isHovered = false;
      _x = 0;
      _y = 0;
    });
    // Use easeOut elasticity to spring back to center
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_x * _animation.value, _y * _animation.value),
            child: widget.child,
          );
        },
      ),
    );
  }
}
