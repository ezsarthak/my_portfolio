import 'package:flutter/material.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class HoverSocialIcon extends StatefulWidget {
  final String link;
  final IconData iconPath;

  const HoverSocialIcon({
    super.key,
    required this.link,
    required this.iconPath,
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
          child: SocialWidget(
            placeholderText: '',
            iconData: widget.iconPath,
            iconColor: _isHovered ? AppColors.purple : Colors.white,
            link: widget.link,
          ),
        ),
      ),
    );
  }
}
