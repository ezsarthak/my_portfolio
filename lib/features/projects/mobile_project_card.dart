import 'package:flutter/material.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileProjectGallery extends StatelessWidget {
  final List<Map<String, dynamic>> projects;

  const MobileProjectGallery({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with fallback icon / image
              Container(
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00d4ff), Color(0xFF7c4dff)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    project['title'].toString().substring(0, 1).toUpperCase(),
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project['title'],
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    
                    // Tech Stack Badges
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (project['tech'] as List<String>).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.purple.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.purple.withValues(alpha: 0.5)),
                          ),
                          child: Text(tech, style: TextStyle(color: AppColors.purple, fontSize: 11, fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    
                    Text(
                      project['description'],
                      style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    
                    // Interactive Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInteractiveButton(
                          text: 'Run',
                          icon: Icons.play_arrow,
                          color: Colors.greenAccent,
                          onTap: () {},
                          filled: true,
                        ),
                        if (project.containsKey('github') && project['github'].toString().isNotEmpty)
                          _buildInteractiveButton(
                            text: 'GitHub',
                            icon: Icons.code,
                            color: Colors.white,
                            onTap: () async {
                              final Uri url = Uri.parse(project['github']);
                              if (!await launchUrl(url)) throw Exception('Could not launch \$url');
                            },
                            filled: false,
                          ),
                        if (project.containsKey('live') && project['live'].toString().isNotEmpty)
                          _buildInteractiveButton(
                            text: 'Live Demo',
                            icon: Icons.open_in_new,
                            color: Colors.blueAccent,
                            onTap: () async {
                              final Uri url = Uri.parse(project['live']);
                              if (!await launchUrl(url)) throw Exception('Could not launch \$url');
                            },
                            filled: false,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInteractiveButton({required String text, required IconData icon, required Color color, required VoidCallback onTap, required bool filled}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: filled ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: filled ? Colors.transparent : color),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: filled ? Colors.black : color, size: 16),
            const SizedBox(width: 6),
            Text(text, style: TextStyle(color: filled ? Colors.black : color, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
