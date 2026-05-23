import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class InternshipsWidget extends StatelessWidget {
  const InternshipsWidget({super.key});

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
            'Internships',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 40),
          Wrap(
            runSpacing: 20,
            spacing: 20,
            direction: Axis.horizontal,
            children: PortfolioData.internships.map((internship) {
              return _buildInternshipCard(
                w, isMobile,
                internship['company']!,
                internship['role']!,
                internship['duration']!,
                internship['description']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInternshipCard(
      double w, bool isMobile, String company, String role, String duration, String desc) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        hoverColor: AppColors.purple.withOpacity(0.1),
        child: Container(
          width: isMobile ? w * 0.8 : w / 2.4,
          height: 220,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.purpleDark.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.violet,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    company[0],
                    style: TextStyle(fontSize: 24, color: AppColors.purple, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      role,
                      style: const TextStyle(
                          fontSize: 22, height: 1.2, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      company,
                      style: TextStyle(fontSize: 16, color: AppColors.purple),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      duration,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
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
            ],
          ),
        ),
      ),
    );
  }
}
