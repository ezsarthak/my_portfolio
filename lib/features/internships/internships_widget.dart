import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:portfolio/design/widgets/tilt_card.dart';

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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.internships.length,
            itemBuilder: (context, index) {
              final internship = PortfolioData.internships[index];
              return _buildTimelineNode(
                w, isMobile, index, PortfolioData.internships.length,
                internship['company']!,
                internship['role']!,
                internship['duration']!,
                internship['description']!,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineNode(
      double w, bool isMobile, int index, int total, String company, String role, String duration, String desc) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline graphics
          SizedBox(
            width: isMobile ? 40 : 80,
            child: Column(
              children: [
                // Top line
                Expanded(
                  child: Container(
                    width: 2,
                    color: index == 0 ? Colors.transparent : AppColors.purple.withValues(alpha: 0.3),
                  ),
                ),
                // Glowing Node
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.purple.withValues(alpha: 0.6),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                ),
                // Bottom line
                Expanded(
                  child: Container(
                    width: 2,
                    color: index == total - 1 ? Colors.transparent : AppColors.purple.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          ),
          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0, top: 0),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.purpleDark.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            role,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        if (!isMobile)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.purple.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.purple.withValues(alpha: 0.5)),
                            ),
                            child: Text(duration, style: TextStyle(color: AppColors.purple, fontSize: 14, fontWeight: FontWeight.bold)),
                          )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(company, style: TextStyle(fontSize: 18, color: AppColors.purple.withValues(alpha: 0.8), fontWeight: FontWeight.w600)),
                    if (isMobile) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.purple.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.purple.withValues(alpha: 0.5)),
                        ),
                        child: Text(duration, style: TextStyle(color: AppColors.purple, fontSize: 14, fontWeight: FontWeight.bold)),
                      )
                    ],
                    const SizedBox(height: 20),
                    Text(desc, style: const TextStyle(height: 1.5, color: Colors.white70, fontSize: 15)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
