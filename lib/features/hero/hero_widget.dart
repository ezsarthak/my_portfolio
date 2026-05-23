import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:portfolio/design/widgets/magnetic_button.dart';
import 'package:portfolio/design/widgets/tilt_card.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/design/widgets/hover_social_icon.dart';

import 'package:rive/rive.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    bool isMobile = w < 800;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : w / 30),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Stack(
        children: [
          // Background Glow
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(
                  blurRadius: 300,
                  spreadRadius: 300,
                  color: AppColors.purple.withValues(alpha: 0.3),
                )
              ]),
            )
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .scaleXY(
                    begin: 1.0,
                    end: 1.2,
                    duration: 4.seconds,
                    curve: Curves.easeInOut),
          ),
          // Rive Animation
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 600,
              height: 600,
              child: RiveAnimation.asset(
                  'assets/animations/intro_animation.riv',
                  fit: BoxFit.contain),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 100.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
          Center(
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildContent(w, isMobile),
                  )
                    .animate()
                    .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                    .slideY(begin: 0.05, end: 0, curve: Curves.easeOutCubic)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildContent(w, isMobile),
                  )
                    .animate()
                    .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                    .slideX(begin: -0.05, end: 0, curve: Curves.easeOutCubic),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildContent(double w, bool isMobile) {
    return [
      TiltCard(
        depth: 20,
        child: CircleAvatar(
          radius: isMobile ? 64 : w / 14,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: isMobile ? 60 : w / 14 - 4,
            backgroundColor: AppColors.purpleDark,
            backgroundImage: const AssetImage('assets/images/self.jpeg'),
          ),
        ),
      ),
      SizedBox(width: isMobile ? 0 : 100, height: isMobile ? 20 : 0),
      Expanded(
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Preah',
                      fontSize: isMobile ? 24 : w / 40),
                  children: [
                    const TextSpan(text: 'I am '),
                    TextSpan(
                        text: '${PortfolioData.name} ',
                        style: TextStyle(color: AppColors.purple))
                  ]),
            ),
            const SizedBox(height: 20),
            const Text(
              'A passionate builder,',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            RichText(
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.white,
                      height: 1.2,
                      fontFamily: 'Preah',
                      fontSize: isMobile ? 32 : w / 20,
                      fontWeight: FontWeight.bold),
                  children: [
                    const TextSpan(text: 'Crafting code to bring\n'),
                    const TextSpan(text: 'ideas to '),
                    TextSpan(
                        text: 'life',
                        style: TextStyle(color: AppColors.purple)),
                    const TextSpan(text: '...')
                  ]),
            ),
            const SizedBox(height: 60),
            Text(
              PortfolioData.tagline,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  height: 1.2,
                  fontFamily: 'Preah',
                  fontSize: isMobile ? 16 : w / 44),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  socialIcon(PortfolioData.github, SocialIconsFlutter.github),
                  socialIcon(PortfolioData.linkedin, SocialIconsFlutter.linkedin_box),
                  socialIcon(PortfolioData.twitter, SocialIconsFlutter.twitter),
                  socialIcon(PortfolioData.medium, FontAwesomeIcons.medium),
                ],
              )
                  .animate(delay: 100.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),
            ),
          
          ],
        ),
      )
    ];
  }

  Widget socialIcon(String link, IconData iconPath) {
    return MagneticButton(
      magneticStrength: 0.3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: HoverSocialIcon(
          link: link,
          iconPath: iconPath,
        ),
      ),
    );
  }
}
