import 'package:flutter/material.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class DsaWidget extends StatelessWidget {
  const DsaWidget({super.key});

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
            'DSA & Competitive Programming',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 40),
          Wrap(
            runSpacing: 20,
            spacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildDsaCard(w, isMobile, '500+', 'Problems Solved'),
              _buildDsaCard(w, isMobile, '1847', 'LeetCode Rating'),
              _buildDsaCard(w, isMobile, '1456', 'Codeforces Rating'),
              _buildDsaCard(w, isMobile, '120 Days', 'Active Streak'),
            ]
          )
        ],
      ),
    );
  }

  Widget _buildDsaCard(double w, bool isMobile, String value, String label) {
    return Container(
      width: isMobile ? w * 0.8 : w / 4.5,
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.violet,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.purpleDark)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
                fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(fontSize: 16, color: AppColors.purple),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
