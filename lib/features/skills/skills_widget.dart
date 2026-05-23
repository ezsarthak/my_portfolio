import 'package:flutter/material.dart';
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
              {'name': 'AWS EC2', 'image': 'assets/icons/aws.svg'},
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
                imagePath: item['image'],
                iconData: item['icon'],
                fallbackText: item['text'],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class HoverTechStackIcon extends StatefulWidget {
  final String name;
  final String? imagePath;
  final IconData? iconData;
  final String? fallbackText;

  const HoverTechStackIcon({
    Key? key,
    required this.name,
    this.imagePath,
    this.iconData,
    this.fallbackText,
  }) : super(key: key);

  @override
  State<HoverTechStackIcon> createState() => _HoverTechStackIconState();
}

class _HoverTechStackIconState extends State<HoverTechStackIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isSvg = widget.imagePath != null && widget.imagePath!.endsWith('.svg');
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(6),
        height: 54,
        padding: EdgeInsets.symmetric(horizontal: _isHovered ? 16 : 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _isHovered ? AppColors.purpleDark : AppColors.violet,
          border: Border.all(
            color: _isHovered ? AppColors.purple : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.imagePath != null)
              isSvg
                  ? SvgPicture.asset(widget.imagePath!, fit: BoxFit.contain, width: 38, height: 38)
                  : Image.asset(widget.imagePath!, fit: BoxFit.contain, width: 38, height: 38)
            else if (widget.iconData != null)
              Icon(widget.iconData, size: 30, color: Colors.white)
            else if (widget.fallbackText != null)
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.purple.withOpacity(0.2),
                ),
                child: Text(
                  widget.fallbackText!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
              ),
            if (_isHovered) ...[
              const SizedBox(width: 10),
              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
