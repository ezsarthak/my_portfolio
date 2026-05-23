import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogsWidget extends StatelessWidget {
  const BlogsWidget({super.key});

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
            'Blogs & Articles',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 40),
          Wrap(
            runSpacing: 20,
            spacing: 20,
            direction: Axis.horizontal,
            children: PortfolioData.blogs.map((blog) {
              return _buildBlogCard(
                w, isMobile,
                blog['title']!,
                blog['date']!,
                blog['description']!,
                blog['link']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(
      double w, bool isMobile, String title, String date, String desc, String link) {
    return Material(
      color: Colors.transparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (link != '#') {
              launchUrl(Uri.parse(link));
            }
          },
          child: Container(
          width: isMobile ? w * 0.8 : w / 2.4,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.purpleDark.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 22, height: 1.2, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                date,
                style: TextStyle(fontSize: 14, color: AppColors.purple),
              ),
              const SizedBox(height: 10),
              Text(
                desc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
