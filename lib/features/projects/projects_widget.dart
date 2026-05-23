import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';

import 'ide_readable.dart';
import 'freelance_dashboard.dart';

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
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          
          IdeProjectGalleryReadable(projects: PortfolioData.devProjects, isMobile: isMobile),
          const SizedBox(height: 100),

          const Text(
            'Freelance Work',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          FreelanceDashboard(projects: PortfolioData.freelanceProjects, isMobile: isMobile),
        ],
      ),
    );
  }
}
