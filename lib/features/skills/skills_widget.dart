import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tech Stack',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 40),
          const Text(
            "My technical skills include frontend, backend, databases, and mobile development technologies.",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 40),
          _buildCategoryRow('Languages', [
            {'name': 'Dart', 'text': 'D'},
            {'name': 'C++', 'text': 'C++'},
            {'name': 'JavaScript', 'icon': FontAwesomeIcons.js},
            {'name': 'C', 'text': 'C'},
          ]),
          _buildCategoryRow('Frameworks & Libraries', [
            {'name': 'Flutter', 'image': 'assets/icons/flutter.svg'},
            {'name': 'Node.js', 'image': 'assets/icons/node.svg'},
            {'name': 'Express.js', 'text': 'Ex'},
          ]),
          _buildCategoryRow('Backend & Database', [
            {'name': 'Firebase', 'image': 'assets/icons/firebase.svg'},
            {'name': 'MongoDB', 'image': 'assets/icons/mongo.svg'},
            {'name': 'PostgreSQL', 'text': 'Pg'},
            {'name': 'Hive', 'text': 'Hv'},
          ]),
          _buildCategoryRow('Cloud & DevOps', [
            {'name': 'AWS EC2', 'icon': FontAwesomeIcons.aws},
            {'name': 'Digital Ocean', 'icon': FontAwesomeIcons.digitalOcean},
            {'name': 'GitHub Actions', 'icon': FontAwesomeIcons.githubAlt},
            {'name': 'CI/CD', 'icon': FontAwesomeIcons.codeBranch},
            {'name': 'Render', 'text': 'R'},
            {'name': 'GitHub', 'image': 'assets/icons/github.svg'},
          ]),
          _buildCategoryRow('Tools', [
            {'name': 'Git', 'image': 'assets/icons/git.png'},
            {'name': 'Postman', 'text': 'Pm'},
            {'name': 'Figma', 'icon': FontAwesomeIcons.figma},
            {'name': 'VS Code', 'text': 'VS'},
          ]),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String title, List<Map<String, dynamic>> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.purple,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.start,
            children: items.map((item) {
              return HoverTechStackIcon(
                name: item['name'],
                icon: item['icon'],
                image: item['image'],
                text: item['text'],
              )
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .slideY(begin: 0.1, end: -0.1, duration: 1500.ms, curve: Curves.easeInOut);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class HoverTechStackIcon extends StatefulWidget {
  final String name;
  final IconData? icon;
  final String? image;
  final String? text;

  const HoverTechStackIcon({
    super.key,
    required this.name,
    this.icon,
    this.image,
    this.text,
  });

  @override
  State<HoverTechStackIcon> createState() => _HoverTechStackIconState();
}

class _HoverTechStackIconState extends State<HoverTechStackIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -5.0 : 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.purpleDark : AppColors.purpleDark.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: _isHovered ? AppColors.purple : Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppColors.purple.withValues(alpha: 0.4),
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              )
            else
              const BoxShadow(
                color: Colors.transparent,
                blurRadius: 0,
                spreadRadius: 0,
              )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.image != null)
              widget.image!.endsWith('.svg')
                  ? SvgPicture.asset(widget.image!, fit: BoxFit.contain, width: 28, height: 28)
                  : Image.asset(widget.image!, fit: BoxFit.contain, width: 28, height: 28)
            else if (widget.icon != null)
              Icon(widget.icon, size: 28, color: Colors.white)
            else if (widget.text != null)
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.purple.withValues(alpha: 0.2),
                ),
                child: Text(
                  widget.text!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                ),
              ),
            const SizedBox(width: 12),
            Text(
              widget.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
