import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class HoverSocialIcon extends StatefulWidget {
  final String link;
  final dynamic iconPath;
  final String? assetPath;

  const HoverSocialIcon({
    super.key,
    required this.link,
    this.iconPath,
    this.assetPath,
  });

  @override
  State<HoverSocialIcon> createState() => _HoverSocialIconState();
}

class _HoverSocialIconState extends State<HoverSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.link)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: widget.assetPath != null
              ? (widget.assetPath!.endsWith('.svg')
                  ? SvgPicture.asset(widget.assetPath!,
                      width: 32,
                      height: 32,
                      colorFilter: ColorFilter.mode(
                          _isHovered ? AppColors.purple : Colors.white,
                          BlendMode.srcIn))
                  : Image.asset(widget.assetPath!,
                      width: 32,
                      height: 32,
                      color: _isHovered ? AppColors.purple : Colors.white))
              : (widget.iconPath is IconData
                  ? Icon(
                      widget.iconPath as IconData,
                      color: _isHovered ? AppColors.purple : Colors.white,
                      size: 32,
                    )
                  : FaIcon(
                      widget.iconPath,
                      color: _isHovered ? AppColors.purple : Colors.white,
                      size: 32,
                    )),
        ),
      ),
    );
  }
}
