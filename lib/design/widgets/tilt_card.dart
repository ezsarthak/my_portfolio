import 'package:flutter/material.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class TiltCard extends StatefulWidget {
  final Widget child;
  final double depth;

  const TiltCard({super.key, required this.child, this.depth = 15.0});

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  bool _isHovered = false;

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -6.0 : 0.0)
          ..scale(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? AppColors.purple.withValues(alpha: 0.8) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppColors.purple.withValues(alpha: 0.4),
                blurRadius: 30,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              )
            else
              const BoxShadow(
                color: Colors.transparent,
                blurRadius: 0,
                spreadRadius: 0,
                offset: Offset(0, 0),
              )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.5),
          child: Stack(
            children: [
              widget.child,
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: _isHovered 
                      ? Colors.white.withValues(alpha: 0.03) 
                      : Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
