import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/widgets/animated_background.dart';
import 'package:portfolio/features/navbar/navbar_widget.dart';
import 'package:portfolio/features/hero/hero_widget.dart';
import 'package:portfolio/features/about/about_widget.dart';
import 'package:portfolio/features/skills/skills_widget.dart';
import 'package:portfolio/features/projects/projects_widget.dart';
import 'package:portfolio/features/internships/internships_widget.dart';
import 'package:portfolio/features/startup/startup_widget.dart';
import 'package:portfolio/features/dsa/dsa_widget.dart';
import 'package:portfolio/features/contact/contact_widget.dart';
import 'package:portfolio/features/blogs/blogs_widget.dart';
import 'package:portfolio/design/widgets/scroll_reveal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  
  final List<GlobalKey> _keys = [];
  final List<String> _sectionNames = [];
  final List<Widget> _sections = [];

  @override
  void initState() {
    super.initState();
    _buildSections();
  }

  void _buildSections() {
    _addSection('Home', const HeroWidget());
    _addSection('About', const AboutWidget());
    _addSection('Skills', const SkillsWidget());
    _addSection('Projects', const ProjectsWidget());
    _addSection('Internships', const InternshipsWidget());
    _addSection('Startup', const StartupWidget());
    if (PortfolioData.showDsaSection) {
      _addSection('DSA', const DsaWidget());
    }
    _addSection('Blogs', const BlogsWidget());
    _addSection('Contact', const ContactWidget());
  }

  void _addSection(String name, Widget widget) {
    _sectionNames.add(name);
    _keys.add(GlobalKey());
    _sections.add(widget);
  }

  void _scrollToSection(int index) {
    Scrollable.ensureVisible(
      _keys[index].currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Stack(
          children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 60), // Space for sticky navbar
                Container(key: _keys[0], child: _sections[0]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      _sections.length - 1, 
                      (index) => ScrollReveal(
                        key: _keys[index + 1],
                        delay: Duration(milliseconds: 100 * (index % 2)),
                        child: _sections[index + 1],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBarWidget(
              sectionNames: _sectionNames,
              onSectionTap: _scrollToSection,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
