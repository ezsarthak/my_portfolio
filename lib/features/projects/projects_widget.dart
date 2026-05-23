import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:portfolio/design/widgets/buttons/app_outlined_button.dart';

class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({super.key});

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
            'Development Projects',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 40),
          Wrap(
            runSpacing: 20,
            spacing: 20,
            direction: Axis.horizontal,
            children: PortfolioData.devProjects.map((project) {
              return _buildProjectCard(
                context,
                isMobile,
                project['title']!,
                project['description']!,
                'VIEW REPO',
                imagePath: project['image'] as String?,
              );
            }).toList(),
          ),
          const SizedBox(height: 60),
          const Text(
            'Freelance Work',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 40),
          Wrap(
            runSpacing: 20,
            spacing: 20,
            direction: Axis.horizontal,
            children: PortfolioData.freelanceProjects.map((project) {
              return _buildProjectCard(
                context,
                isMobile,
                project['title']!,
                project['description']!,
                'VIEW CLIENT',
                imagePath: project['image'] as String?,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
      BuildContext context, bool isMobile, String title, String desc, String buttonText, {String? imagePath}) {
    double w = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        hoverColor: AppColors.purple.withOpacity(0.1),
        child: Container(
          width: isMobile ? w * 0.8 : w / 2.4,
          height: 260,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.purpleDark.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.violet,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.code, color: AppColors.purple, size: 40),
                ),
              const SizedBox(width: 20),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24, height: 1.4, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      desc,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 15),
                    AppOutlinedButton(
                      title: buttonText,
                      textStyle: const TextStyle(fontSize: 12),
                      height: 35,
                      width: 120,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
