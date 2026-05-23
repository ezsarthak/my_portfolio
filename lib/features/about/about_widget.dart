import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    bool isMobile = w < 800;

    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Me',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 40),
          Text(
            PortfolioData.bio,
            style: const TextStyle(fontSize: 18, height: 1.5),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 40),
          Wrap(
            runSpacing: 30,
            spacing: 30,
            alignment: WrapAlignment.start,
            children: PortfolioData.quickStats.map((stat) => _buildStatCard(w, isMobile, stat['value']!, stat['label']!, stat['image']!)).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildStatCard(double w, bool isMobile, String value, String label, String imagePath) {
    return Container(
      width: isMobile ? w * 0.9 : w / 4.5,
      height: 180,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
          color: AppColors.purpleDark.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.contain),
          const SizedBox(width: 25),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 28, color: AppColors.purple, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  label,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
