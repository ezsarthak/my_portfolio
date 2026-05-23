import 'package:flutter/material.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class AppOutlinedButton extends StatefulWidget {
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final String title;
  final TextStyle? textStyle;
  final Color? borderColor;
  final bool? enabled;
  const AppOutlinedButton(
      {super.key,
      this.onTap,
      this.height,
      this.width,
      required this.title,
      this.enabled = true,
      this.textStyle,
      this.borderColor});

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends State<AppOutlinedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.enabled ?? true;
    final Color defaultBgColor = isEnabled ? AppColors.purpleDark : Colors.grey.shade500;
    final Color hoverBgColor = isEnabled ? AppColors.purple : Colors.grey.shade500;

    return MouseRegion(
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: isEnabled ? widget.onTap : () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          height: widget.height ?? 33,
          width: widget.width ?? 177,
          transform: Matrix4.identity()..scaleByDouble(_isHovered && isEnabled ? 1.05 : 1.0, _isHovered && isEnabled ? 1.05 : 1.0, 1.0, 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: widget.borderColor ?? AppColors.purple),
            borderRadius: BorderRadius.circular(8),
            color: _isHovered ? hoverBgColor : defaultBgColor,
            boxShadow: [
              if (_isHovered && isEnabled)
                BoxShadow(
                  color: AppColors.purple.withValues(alpha: 0.4),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              else
                const BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 0,
                  spreadRadius: 0,
                )
            ],
          ),
          child: Center(
            child: Text(
              widget.title,
              style: widget.textStyle ?? const TextStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
