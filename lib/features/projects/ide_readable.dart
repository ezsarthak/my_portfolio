import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class IdeProjectGalleryReadable extends StatefulWidget {
  final List<Map<String, dynamic>> projects;
  final bool isMobile;
  const IdeProjectGalleryReadable({super.key, required this.projects, required this.isMobile});

  @override
  State<IdeProjectGalleryReadable> createState() => _IdeProjectGalleryReadableState();
}

class _IdeProjectGalleryReadableState extends State<IdeProjectGalleryReadable> {
  int activeIndex = 0;
  List<String> terminalLines = [
    'sarthak@nexus-machine:~/portfolio/projects\$ ',
  ];
  late List<String> files;
  bool isPanelOpen = false;
  int? hoveredSidebarIndex;

  @override
  void initState() {
    super.initState();
    files = _generateFiles(widget.projects);
  }

  List<String> _generateFiles(List<Map<String, dynamic>> projects) {
    List<String> result = ['Welcome.md'];
    for (var p in projects) {
      String name = p['title'].toString().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_').replaceAll('___', '_').replaceAll('__', '_');
      if (name.endsWith('_')) name = name.substring(0, name.length - 1);
      
      // Determine file extension based on tech stack
      String ext = '.ts';
      String desc = p['description'].toString().toLowerCase();
      if (desc.contains('flutter') || desc.contains('dart')) {
        ext = '.dart';
      } else if (desc.contains('python') || desc.contains('ai') || desc.contains('prediction')) {
        ext = '.py';
      } else if (desc.contains('react') || desc.contains('next.js')) {
        ext = '.tsx';
      } else if (desc.contains('node') || desc.contains('express') || desc.contains('api')) {
        ext = '.js';
      }
      
      result.add('$name$ext');
    }
    return result;
  }

  void _runProject() {
    if (activeIndex == 0) return;
    var project = widget.projects[activeIndex - 1];
    String file = files[activeIndex];
    
    setState(() {
      isPanelOpen = true;
      terminalLines.add('sarthak@nexus-machine:~/portfolio/projects\$ ./run $file');
      terminalLines.add('\x1B[33m[INFO]\x1B[0m Starting build process for ${project['title']}...');
    });
    
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          terminalLines.add('\x1B[36m[BUILD]\x1B[0m Resolving dependencies...');
          terminalLines.add('\x1B[36m[BUILD]\x1B[0m Compiling application core...');
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) {
        setState(() {
          terminalLines.add('\x1B[32m[SUCCESS]\x1B[0m Environment launched successfully! Ready for action.');
          terminalLines.add('sarthak@nexus-machine:~/portfolio/projects\$ ');
        });
      }
    });
  }

  Widget _buildTerminalLine(String line) {
    if (line.startsWith('sarthak@')) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
            children: [
              const TextSpan(text: 'sarthak@nexus-machine', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
              const TextSpan(text: ':', style: TextStyle(color: Colors.white)),
              const TextSpan(text: '~/portfolio/projects\$ ', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
              TextSpan(text: line.substring(line.indexOf('\$') + 1), style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    }
    
    Color color = Colors.white70;
    if (line.contains('[INFO]')) color = Colors.blueAccent;
    if (line.contains('[BUILD]')) color = Colors.cyanAccent;
    if (line.contains('[SUCCESS]')) color = Colors.greenAccent;
    if (line.contains('[ERROR]')) color = Colors.redAccent;
    
    String cleanLine = line.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '');
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(cleanLine, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 13)),
    );
  }

  Widget _buildFileContent(int index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.handshake_outlined, size: 64, color: Colors.blueAccent),
            const SizedBox(height: 24),
            const Text("Welcome to my Workspace!", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text("This is a modern, fully interactive VS Code environment built with Flutter.", style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.5)),
            const SizedBox(height: 32),
            const Text("Getting Started", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildFeatureRow(Icons.account_tree_outlined, "Select a file in the EXPLORER to view project details."),
            _buildFeatureRow(Icons.play_arrow_outlined, "Click the 'Run' button in the editor header to execute a project simulation."),
            _buildFeatureRow(Icons.terminal, "Watch the terminal output build the project in real-time."),
          ],
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
      );
    }

    var project = widget.projects[index - 1];
    String firstLetter = project['title'].toString().substring(0, 1).toUpperCase();

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use Image from assets if available, else fallback
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF252526),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8))
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: project.containsKey('image') && project['image'].toString().isNotEmpty
                    ? Image.asset(project['image'], fit: BoxFit.cover, errorBuilder: (ctx, err, stack) => _buildFallbackIcon(firstLetter))
                    : _buildFallbackIcon(firstLetter),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project['title'], style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.verified, color: Colors.blueAccent, size: 16),
                        const SizedBox(width: 8),
                        const Text('Sarthak Patil', style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.w600)),
                        if (project.containsKey('stars') && project['stars'] != null && project['stars'].toString().isNotEmpty) ...[
                          const SizedBox(width: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(project['stars'].toString(), style: const TextStyle(color: Colors.white70, fontSize: 16)),
                        ],
                        if (project.containsKey('downloads') && project['downloads'] != null && project['downloads'].toString().isNotEmpty) ...[
                          const SizedBox(width: 16),
                          const Icon(Icons.download, color: Colors.white54, size: 16),
                          const SizedBox(width: 4),
                          Text(project['downloads'].toString(), style: const TextStyle(color: Colors.white54, fontSize: 16)),
                        ],
                      ],
                    ),
                    if (project.containsKey('tech') && project['tech'] != null && (project['tech'] as List).isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (project['tech'] as List<dynamic>).map((t) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D30),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Text(t.toString(), style: const TextStyle(fontSize: 13, color: Colors.white)),
                        )).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              _buildInteractiveButton(
                text: 'Run Simulation',
                icon: Icons.play_arrow,
                color: Colors.greenAccent,
                onTap: _runProject,
                filled: true,
              ),
              const SizedBox(width: 16),
              _buildInteractiveButton(
                text: 'GitHub Repo',
                icon: Icons.code,
                color: Colors.white,
                onTap: () async {
                  final url = Uri.parse(project['github'].toString());
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                filled: false,
              ),
              if (project['live'] != null && project['live'].toString().isNotEmpty && project['live'] != '#') ...[
                const SizedBox(width: 16),
                _buildInteractiveButton(
                  text: 'Live Demo',
                  icon: Icons.open_in_new,
                  color: Colors.blueAccent,
                  onTap: () async {
                    final url = Uri.parse(project['live'].toString());
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                  filled: false,
                ),
              ]
            ],
          ),
          const SizedBox(height: 48),
          const Text('Overview', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF333333)),
          const SizedBox(height: 16),
          Text(project['description'], style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.8)),
          const SizedBox(height: 40),
          
          // Enhanced Detail Section
          if (project.containsKey('technicalDetails') && project['technicalDetails'] != null && (project['technicalDetails'] as List).isNotEmpty) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Technical Details', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ...(project['technicalDetails'] as List<dynamic>).map((detail) {
                        IconData icon = Icons.check_circle_outline;
                        String dStr = detail.toString().toLowerCase();
                        if (dStr.contains('api') || dStr.contains('rest') || dStr.contains('communication')) {
                          icon = Icons.api;
                        } else if (dStr.contains('architecture') || dStr.contains('clean') || dStr.contains('structure') || dStr.contains('design')) {
                          icon = Icons.architecture;
                        } else if (dStr.contains('performance') || dStr.contains('fast') || dStr.contains('speed') || dStr.contains('latency') || dStr.contains('optimiz')) {
                          icon = Icons.speed;
                        } else if (dStr.contains('security') || dStr.contains('secure') || dStr.contains('auth') || dStr.contains('encrypt')) {
                          icon = Icons.security;
                        } else if (dStr.contains('database') || dStr.contains('query') || dStr.contains('data') || dStr.contains('sql') || dStr.contains('mongo')) {
                          icon = Icons.storage;
                        } else if (dStr.contains('ai') || dStr.contains('model') || dStr.contains('predict') || dStr.contains('vision')) {
                          icon = Icons.psychology;
                        }
                        return _buildFeatureRow(icon, detail.toString());
                      }),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Project Status', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF252526),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Deployment', style: TextStyle(color: Colors.white70)),
                                Text('Production Ready', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(color: Colors.white12),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Maintenance', style: TextStyle(color: Colors.white70)),
                                Text('Active', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Project Status', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF252526),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Deployment', style: TextStyle(color: Colors.white70)),
                                Text('Production Ready', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(color: Colors.white12),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Maintenance', style: TextStyle(color: Colors.white70)),
                                Text('Active', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ).animate(key: ValueKey(index)).fadeIn(duration: 400.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildFallbackIcon(String firstLetter) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00d4ff), Color(0xFF7c4dff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(firstLetter, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5))),
        ],
      ),
    );
  }

  Widget _buildInteractiveButton({required String text, required IconData icon, required Color color, required VoidCallback onTap, required bool filled}) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: filled 
                    ? (isHovered ? color.withValues(alpha: 0.8) : color) 
                    : (isHovered ? Colors.white.withValues(alpha: 0.1) : Colors.transparent),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: filled ? Colors.transparent : Colors.white24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: filled ? Colors.black : color, size: 20),
                  const SizedBox(width: 8),
                  Text(text, style: TextStyle(color: filled ? Colors.black : color, fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  String _getLanguage(String filename) {
    if (filename.endsWith('.dart')) return 'Dart';
    if (filename.endsWith('.py')) return 'Python';
    if (filename.endsWith('.tsx')) return 'TypeScript React';
    if (filename.endsWith('.js')) return 'JavaScript';
    if (filename.endsWith('.md')) return 'Markdown';
    return 'TypeScript';
  }

  IconData _getFileIcon(String ext) {
    if (ext == 'dart') return Icons.code;
    if (ext == 'py') return Icons.data_object;
    if (ext == 'tsx' || ext == 'js') return Icons.web;
    if (ext == 'md') return Icons.info_outline;
    return Icons.insert_drive_file;
  }
  
  Color _getFileColor(String ext) {
    if (ext == 'dart') return Colors.blue;
    if (ext == 'py') return Colors.yellow;
    if (ext == 'tsx') return Colors.blueAccent;
    if (ext == 'js') return Colors.yellowAccent;
    if (ext == 'md') return Colors.purpleAccent;
    return Colors.white70;
  }

  Widget _buildMacButton(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800, // Taller to accommodate more details
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Standard VS Code Dark+ Editor Background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF333333)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 30, offset: const Offset(0, 15))
        ],
      ),
      child: Column(
        children: [
          // 1. Title Bar
          Container(
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFF181818), // VS Code modern title bar
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                _buildMacButton(Colors.redAccent),
                const SizedBox(width: 8),
                _buildMacButton(Colors.orangeAccent),
                const SizedBox(width: 8),
                _buildMacButton(Colors.greenAccent),
                Expanded(
                  child: Center(
                    child: Text(
                      '${files[activeIndex]} - portfolio_workspace - VS Code',
                      style: const TextStyle(color: Color(0xFF999999), fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 60),
              ],
            ),
          ),
          
          // 2. Main Body
          Expanded(
            child: Row(
              children: [
                // Activity Bar
                Container(
                  width: 55,
                  color: const Color(0xFF181818),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          border: Border(left: BorderSide(color: Colors.blueAccent, width: 3)),
                        ),
                        child: const Icon(Icons.file_copy_outlined, color: Colors.white, size: 28),
                      ),
                      const SizedBox(height: 16),
                      const Icon(Icons.search, color: Colors.white54, size: 28),
                      const SizedBox(height: 24),
                      const Icon(Icons.account_tree_outlined, color: Colors.white54, size: 28),
                      const SizedBox(height: 24),
                      const Icon(Icons.extension_outlined, color: Colors.white54, size: 28),
                      const Spacer(),
                      const Icon(Icons.account_circle_outlined, color: Colors.white54, size: 28),
                      const SizedBox(height: 20),
                      const Icon(Icons.settings_outlined, color: Colors.white54, size: 28),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                
                // Sidebar
                if (!widget.isMobile)
                  Container(
                    width: 260,
                    color: const Color(0xFF181818),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                          child: Text('EXPLORER', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                          child: Row(
                            children: [
                              Icon(Icons.keyboard_arrow_down, color: Colors.white.withValues(alpha: 0.8), size: 18),
                              const SizedBox(width: 4),
                              Text('PORTFOLIO_WORKSPACE', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        ...files.asMap().entries.map((e) {
                          bool isActive = e.key == activeIndex;
                          bool isHovered = e.key == hoveredSidebarIndex;
                          String ext = e.value.split('.').last;
                          Color iconColor = _getFileColor(ext);
                          IconData iconData = _getFileIcon(ext);
                          
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => hoveredSidebarIndex = e.key),
                            onExit: (_) => setState(() => hoveredSidebarIndex = null),
                            child: GestureDetector(
                              onTap: () => setState(() => activeIndex = e.key),
                              child: Container(
                                color: isActive ? const Color(0xFF37373D) : (isHovered ? const Color(0xFF2A2D2E) : Colors.transparent),
                                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 6.0),
                                child: Row(
                                  children: [
                                    Icon(iconData, color: iconColor, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        e.value,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: isActive ? Colors.white : const Color(0xFFCCCCCC), fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                
                // Editor Area
                Expanded(
                  child: Container(
                    color: const Color(0xFF1E1E1E),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tabs
                        Container(
                          height: 40,
                          color: const Color(0xFF181818),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  border: Border(top: BorderSide(color: Colors.blueAccent, width: 2)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(_getFileIcon(files[activeIndex].split('.').last), color: _getFileColor(files[activeIndex].split('.').last), size: 16),
                                    const SizedBox(width: 8),
                                    Container(
                                      constraints: const BoxConstraints(maxWidth: 150),
                                      child: Text(
                                        files[activeIndex],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.close, color: Colors.white54, size: 16),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.splitscreen, color: Colors.white54, size: 20),
                                onPressed: () {},
                                tooltip: 'Split Editor',
                              ),
                              if (activeIndex != 0)
                                IconButton(
                                  icon: const Icon(Icons.play_arrow, color: Colors.greenAccent, size: 22),
                                  onPressed: _runProject,
                                  tooltip: 'Run Project',
                                ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                        
                        // Breadcrumbs
                        Container(
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFF2D2D2D))),
                          ),
                          child: Row(
                            children: [
                              Text('portfolio_workspace', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
                              Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.6), size: 18),
                              Text('projects', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
                              Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.6), size: 18),
                              Expanded(
                                child: Text(
                                  files[activeIndex],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Content
                        Expanded(
                          child: SingleChildScrollView(
                            child: _buildFileContent(activeIndex),
                          ),
                        ),
                        
                        // Panel / Terminal
                        if (isPanelOpen)
                          Container(
                            height: 250,
                            decoration: const BoxDecoration(
                              border: Border(top: BorderSide(color: Color(0xFF333333))),
                              color: Color(0xFF1E1E1E),
                            ),
                            child: Column(
                              children: [
                                // Panel Header
                                Container(
                                  height: 38,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      const Text('PROBLEMS', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                      const SizedBox(width: 24),
                                      const Text('OUTPUT', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                      const SizedBox(width: 24),
                                      const Text('DEBUG CONSOLE', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                      const SizedBox(width: 24),
                                      const Text('TERMINAL', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: Colors.blueAccent, decorationThickness: 2)),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.close, color: Colors.white54, size: 18),
                                        onPressed: () => setState(() => isPanelOpen = false),
                                      ),
                                    ],
                                  ),
                                ),
                                // Panel Body
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: terminalLines.map((l) => _buildTerminalLine(l)).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 3. Status Bar
          Container(
            height: 26,
            color: const Color(0xFF007ACC), // VS Code Blue Status Bar
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.call_split, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                const Text('main*', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(width: 20),
                const Icon(Icons.error_outline, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                const Text('0', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(width: 12),
                const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                const Text('0', style: TextStyle(color: Colors.white, fontSize: 13)),
                const Spacer(),
                const Text('Ln 1, Col 1', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(width: 20),
                const Text('Spaces: 2', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(width: 20),
                const Text('UTF-8', style: TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(width: 20),
                Text(_getLanguage(files[activeIndex]), style: const TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(width: 20),
                const Icon(Icons.notifications_none, color: Colors.white, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
