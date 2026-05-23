import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:portfolio/design/widgets/buttons/app_outlined_button.dart';

class NavBarWidget extends StatelessWidget {
  final List<String> sectionNames;
  final Function(int) onSectionTap;

  const NavBarWidget({
    super.key,
    required this.sectionNames,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    bool isMobile = w < 800;

    return Container(
        height: 60,
        width: double.maxFinite,
        color: AppColors.navBarColor,
        child: Center(
            child: Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.purpleDark.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.purple.withValues(alpha: 0.5), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.code_rounded, color: AppColors.purple, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    PortfolioData.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            if (!isMobile)
              Row(
                children: List.generate(sectionNames.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: HoverNavLink(
                      title: sectionNames[index],
                      onTap: () => onSectionTap(index),
                    ),
                  );
                }),
              ),
            AppOutlinedButton(
              title: 'Download Resume',
              height: 35,
              width: 140,
              textStyle: const TextStyle(fontSize: 12),
              onTap: () {},
            )
          ],
        )));
  }
}

class HoverNavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const HoverNavLink({super.key, required this.title, required this.onTap});

  @override
  State<HoverNavLink> createState() => _HoverNavLinkState();
}

class _HoverNavLinkState extends State<HoverNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          style: GoogleFonts.inter(
            color: _isHovered ? AppColors.purple : Colors.white70,
            fontSize: 14,
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}
