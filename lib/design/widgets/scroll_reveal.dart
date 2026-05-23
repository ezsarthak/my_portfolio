import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const ScrollReveal({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _isVisible = false;
  bool _hasAnimated = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(), // Don't use widget.key as it's passed to ScrollReveal itself
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_hasAnimated) {
          if (mounted) {
            _hasAnimated = true;
            Future.delayed(widget.delay, () {
              if (mounted) {
                setState(() {
                  _isVisible = true;
                });
              }
            });
          }
        }
      },
      child: widget.child.animate(target: _isVisible ? 1 : 0)
          .fadeIn(duration: 400.ms, curve: Curves.easeOut)
          .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
    );
  }
}
