import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/design/widgets/hover_social_icon.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Contact Me',
          style: TextStyle(fontSize: 40),
        ),
        const SizedBox(height: 40),
        const Text(
            "If you are a student, entrepreneur or just want to chat with me, drop me an interesting mail at 👇"),
        const SizedBox(height: 8),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: PortfolioData.email,
              );
              await launchUrl(emailLaunchUri);
            },
            child: Text(
              PortfolioData.email,
              style: TextStyle(
                color: AppColors.purple, 
                fontSize: 18,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.purple,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              socialIcon(PortfolioData.github, SocialIconsFlutter.github),
              const SizedBox(width: 12),
              socialIcon(PortfolioData.linkedin, SocialIconsFlutter.linkedin_box),
              const SizedBox(width: 12),
              socialIcon(PortfolioData.twitter, SocialIconsFlutter.twitter),
            ],
          ),
        ),
        const SizedBox(height: 40),
        const Divider(),
        const SizedBox(height: 20),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Coded by ${PortfolioData.firstName} with 💚 in India'),
            ],
          ),
        )
      ]),
    );
  }

  Widget socialIcon(String link, IconData iconPath) {
    return HoverSocialIcon(
      link: link,
      iconPath: iconPath,
    );
  }
}
