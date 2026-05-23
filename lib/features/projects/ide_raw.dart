import 'package:flutter/material.dart';

class IdeProjectGalleryRaw extends StatefulWidget {
  final List<Map<String, dynamic>> projects;
  final bool isMobile;
  const IdeProjectGalleryRaw({super.key, required this.projects, required this.isMobile});

  @override
  State<IdeProjectGalleryRaw> createState() => _IdeProjectGalleryRawState();
}

class _IdeProjectGalleryRawState extends State<IdeProjectGalleryRaw> {
  int activeIndex = 0;
  List<String> terminalLines = [
    'sarthak@nexus-machine:~/portfolio/projects\$ ',
  ];
  late List<String> files;
  bool isPanelOpen = false;

  @override
  void initState() {
    super.initState();
    files = _generateFiles(widget.projects);
  }

  List<String> _generateFiles(List<Map<String, dynamic>> projects) {
    List<String> result = ['README.md'];
    for (var p in projects) {
      String ext = '.ts';
      List<String> tech = (p['tech'] as List<dynamic>? ?? []).map((e) => e.toString().toLowerCase()).toList();
      if (tech.contains('flutter') || tech.contains('dart')) {
        ext = '.dart';
      } else if (tech.contains('python') || tech.contains('django') || tech.contains('fastapi') || tech.contains('tensorflow')) {
        ext = '.py';
      } else if (tech.contains('react') || tech.contains('next.js')) {
        ext = '.tsx';
      } else if (tech.contains('node.js') || tech.contains('express')) {
        ext = '.js';
      }
      
      String name = p['title'].toString().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
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
          terminalLines.add('\x1B[36m[BUILD]\x1B[0m Compiling ${project['tech'].join(', ')}...');
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

  Widget _buildLine(int line, List<TextSpan> spans) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(line.toString(), textAlign: TextAlign.right, style: const TextStyle(color: Color(0xFF6E7681), fontFamily: 'monospace', fontSize: 13)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14, height: 1.5),
                children: spans,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextSpan ts(String text, Color color) {
    return TextSpan(text: text, style: TextStyle(color: color));
  }

  List<Widget> _buildFileContent(int index) {
    if (index == 0) {
      return [
        _buildLine(1, [ts('#', const Color(0xFF569CD6)), ts(' Portfolio Projects', const Color(0xFFCE9178))]),
        _buildLine(2, []),
        _buildLine(3, [ts('Welcome to my development workspace!', const Color(0xFFCE9178))]),
        _buildLine(4, []),
        _buildLine(5, [ts('Here you can explore my recent projects.', const Color(0xFFCE9178))]),
        _buildLine(6, [ts('Click on any file in the Explorer on the left', const Color(0xFFCE9178))]),
        _buildLine(7, [ts('to view its technical details and source code.', const Color(0xFFCE9178))]),
        _buildLine(8, []),
        _buildLine(9, [ts('##', const Color(0xFF569CD6)), ts(' Instructions', const Color(0xFFCE9178))]),
        _buildLine(10, [ts('-', const Color(0xFF569CD6)), ts(' Select a file in the sidebar.', const Color(0xFF9CDCFE))]),
        _buildLine(11, [ts('-', const Color(0xFF569CD6)), ts(' Click the "Run" icon in the top right', const Color(0xFF9CDCFE))]),
        _buildLine(12, [ts('  to execute the project and view terminal output.', const Color(0xFF9CDCFE))]),
      ];
    }

    var project = widget.projects[index - 1];
    String file = files[index];
    String ext = file.split('.').last;

    if (ext == 'dart') {
      return _buildDartCode(project);
    } else if (ext == 'py') {
      return _buildPythonCode(project);
    } else {
      return _buildTsxCode(project);
    }
  }

  List<Widget> _buildDartCode(Map<String, dynamic> project) {
    String className = project['title'].toString().replaceAll(' ', '');
    List<String> tech = (project['tech'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    
    return [
      _buildLine(1, [ts('import ', const Color(0xFF569CD6)), ts("'package:flutter/material.dart'", const Color(0xFFCE9178)), ts(';', const Color(0xFFD4D4D4))]),
      _buildLine(2, [ts('import ', const Color(0xFF569CD6)), ts("'package:portfolio/models/project.dart'", const Color(0xFFCE9178)), ts(';', const Color(0xFFD4D4D4))]),
      _buildLine(3, []),
      _buildLine(4, [ts('class ', const Color(0xFF569CD6)), ts(className, const Color(0xFF4EC9B0)), ts(' extends ', const Color(0xFF569CD6)), ts('Project ', const Color(0xFF4EC9B0)), ts('{', const Color(0xFFD4D4D4))]),
      _buildLine(5, [ts('  @override', const Color(0xFFDCDCAA))]),
      _buildLine(6, [ts('  ', const Color(0xFFD4D4D4)), ts('String ', const Color(0xFF4EC9B0)), ts('get ', const Color(0xFF569CD6)), ts('title ', const Color(0xFF9CDCFE)), ts('=> ', const Color(0xFF569CD6)), ts('"${project['title']}"', const Color(0xFFCE9178)), ts(';', const Color(0xFFD4D4D4))]),
      _buildLine(7, []),
      _buildLine(8, [ts('  @override', const Color(0xFFDCDCAA))]),
      _buildLine(9, [ts('  ', const Color(0xFFD4D4D4)), ts('String ', const Color(0xFF4EC9B0)), ts('get ', const Color(0xFF569CD6)), ts('description ', const Color(0xFF9CDCFE)), ts('=> ', const Color(0xFF569CD6)), ts('"${project['description']}"', const Color(0xFFCE9178)), ts(';', const Color(0xFFD4D4D4))]),
      _buildLine(10, []),
      _buildLine(11, [ts('  @override', const Color(0xFFDCDCAA))]),
      _buildLine(12, [ts('  ', const Color(0xFFD4D4D4)), ts('List', const Color(0xFF4EC9B0)), ts('<', const Color(0xFFD4D4D4)), ts('String', const Color(0xFF4EC9B0)), ts('> ', const Color(0xFFD4D4D4)), ts('get ', const Color(0xFF569CD6)), ts('techStack ', const Color(0xFF9CDCFE)), ts('=> [', const Color(0xFFD4D4D4))]),
      ...tech.asMap().entries.map((e) => _buildLine(13 + e.key, [ts('    "${e.value}"', const Color(0xFFCE9178)), ts(',', const Color(0xFFD4D4D4))])),
      _buildLine(13 + tech.length, [ts('  ];', const Color(0xFFD4D4D4))]),
      _buildLine(14 + tech.length, []),
      _buildLine(15 + tech.length, [ts('  ', const Color(0xFFD4D4D4)), ts('void ', const Color(0xFF569CD6)), ts('launch', const Color(0xFFDCDCAA)), ts('() {', const Color(0xFFD4D4D4))]),
      _buildLine(16 + tech.length, [ts('    ', const Color(0xFFD4D4D4)), ts('print', const Color(0xFFDCDCAA)), ts('(', const Color(0xFFD4D4D4)), ts('"Initializing \$', const Color(0xFFCE9178)), ts('title', const Color(0xFF9CDCFE)), ts(' services..."', const Color(0xFFCE9178)), ts(');', const Color(0xFFD4D4D4))]),
      _buildLine(17 + tech.length, [ts('  }', const Color(0xFFD4D4D4))]),
      _buildLine(18 + tech.length, [ts('}', const Color(0xFFD4D4D4))]),
    ];
  }

  List<Widget> _buildPythonCode(Map<String, dynamic> project) {
    String className = project['title'].toString().replaceAll(' ', '');
    List<String> tech = (project['tech'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    
    return [
      _buildLine(1, [ts('from ', const Color(0xFF569CD6)), ts('core.project ', const Color(0xFF4EC9B0)), ts('import ', const Color(0xFF569CD6)), ts('Project', const Color(0xFF4EC9B0))]),
      _buildLine(2, []),
      _buildLine(3, [ts('class ', const Color(0xFF569CD6)), ts(className, const Color(0xFF4EC9B0)), ts('(Project):', const Color(0xFFD4D4D4))]),
      _buildLine(4, [ts('    def ', const Color(0xFF569CD6)), ts('__init__', const Color(0xFFDCDCAA)), ts('(self):', const Color(0xFFD4D4D4))]),
      _buildLine(5, [ts('        super().__init__()', const Color(0xFFD4D4D4))]),
      _buildLine(6, [ts('        self.title = ', const Color(0xFFD4D4D4)), ts('"${project['title']}"', const Color(0xFFCE9178))]),
      _buildLine(7, [ts('        self.description = ', const Color(0xFFD4D4D4)), ts('"${project['description']}"', const Color(0xFFCE9178))]),
      _buildLine(8, [ts('        self.tech_stack = [', const Color(0xFFD4D4D4))]),
      ...tech.asMap().entries.map((e) => _buildLine(9 + e.key, [ts('            "${e.value}"', const Color(0xFFCE9178)), ts(',', const Color(0xFFD4D4D4))])),
      _buildLine(9 + tech.length, [ts('        ]', const Color(0xFFD4D4D4))]),
      _buildLine(10 + tech.length, []),
      _buildLine(11 + tech.length, [ts('    def ', const Color(0xFF569CD6)), ts('launch', const Color(0xFFDCDCAA)), ts('(self):', const Color(0xFFD4D4D4))]),
      _buildLine(12 + tech.length, [ts('        ', const Color(0xFFD4D4D4)), ts('print', const Color(0xFFDCDCAA)), ts('(f', const Color(0xFF569CD6)), ts('"Starting {', const Color(0xFFCE9178)), ts('self.title', const Color(0xFF9CDCFE)), ts('} environment..."', const Color(0xFFCE9178)), ts(')', const Color(0xFFD4D4D4))]),
    ];
  }

  List<Widget> _buildTsxCode(Map<String, dynamic> project) {
    String className = project['title'].toString().replaceAll(' ', '');
    List<String> tech = (project['tech'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    
    return [
      _buildLine(1, [ts('import ', const Color(0xFF569CD6)), ts('React ', const Color(0xFF9CDCFE)), ts('from ', const Color(0xFF569CD6)), ts("'react'", const Color(0xFFCE9178)), ts(';', const Color(0xFFD4D4D4))]),
      _buildLine(2, [ts('import ', const Color(0xFF569CD6)), ts('{ ', const Color(0xFFD4D4D4)), ts('ProjectCard', const Color(0xFF4EC9B0)), ts(' } ', const Color(0xFFD4D4D4)), ts('from ', const Color(0xFF569CD6)), ts("'@/components'", const Color(0xFFCE9178)), ts(';', const Color(0xFFD4D4D4))]),
      _buildLine(3, []),
      _buildLine(4, [ts('export const ', const Color(0xFF569CD6)), ts(className, const Color(0xFF4EC9B0)), ts(': ', const Color(0xFFD4D4D4)), ts('React', const Color(0xFF4EC9B0)), ts('.', const Color(0xFFD4D4D4)), ts('FC', const Color(0xFF4EC9B0)), ts(' = () ', const Color(0xFF569CD6)), ts('=>', const Color(0xFF569CD6)), ts(' {', const Color(0xFFD4D4D4))]),
      _buildLine(5, [ts('  const ', const Color(0xFF569CD6)), ts('project ', const Color(0xFF9CDCFE)), ts('= {', const Color(0xFFD4D4D4))]),
      _buildLine(6, [ts('    title: ', const Color(0xFF9CDCFE)), ts('"${project['title']}"', const Color(0xFFCE9178)), ts(',', const Color(0xFFD4D4D4))]),
      _buildLine(7, [ts('    description: ', const Color(0xFF9CDCFE)), ts('"${project['description']}"', const Color(0xFFCE9178)), ts(',', const Color(0xFFD4D4D4))]),
      _buildLine(8, [ts('    techStack: ', const Color(0xFF9CDCFE)), ts('[', const Color(0xFFD4D4D4))]),
      ...tech.asMap().entries.map((e) => _buildLine(9 + e.key, [ts('      "${e.value}"', const Color(0xFFCE9178)), ts(',', const Color(0xFFD4D4D4))])),
      _buildLine(9 + tech.length, [ts('    ],', const Color(0xFFD4D4D4))]),
      _buildLine(10 + tech.length, [ts('  };', const Color(0xFFD4D4D4))]),
      _buildLine(11 + tech.length, []),
      _buildLine(12 + tech.length, [ts('  return ', const Color(0xFF569CD6)), ts('<', const Color(0xFF808080)), ts('ProjectCard', const Color(0xFF4EC9B0)), ts(' data', const Color(0xFF9CDCFE)), ts('=', const Color(0xFFD4D4D4)), ts('{', const Color(0xFF569CD6)), ts('project', const Color(0xFF9CDCFE)), ts('}', const Color(0xFF569CD6)), ts(' />', const Color(0xFF808080)), ts(';', const Color(0xFFD4D4D4))]),
      _buildLine(13 + tech.length, [ts('};', const Color(0xFFD4D4D4))]),
    ];
  }

  String _getLanguage(String filename) {
    if (filename.endsWith('.dart')) return 'Dart';
    if (filename.endsWith('.py')) return 'Python';
    if (filename.endsWith('.tsx')) return 'TypeScript React';
    if (filename.endsWith('.md')) return 'Markdown';
    if (filename.endsWith('.js')) return 'JavaScript';
    return 'TypeScript';
  }

  IconData _getFileIcon(String ext) {
    if (ext == 'dart') return Icons.code;
    if (ext == 'py') return Icons.data_object;
    if (ext == 'md') return Icons.info_outline;
    if (ext == 'tsx' || ext == 'js') return Icons.web;
    return Icons.insert_drive_file;
  }
  
  Color _getFileColor(String ext) {
    if (ext == 'dart') return Colors.blue;
    if (ext == 'py') return Colors.yellow;
    if (ext == 'md') return Colors.purpleAccent;
    if (ext == 'tsx') return Colors.blueAccent;
    if (ext == 'js') return Colors.yellowAccent;
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
      height: 700,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF333333)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        children: [
          // 1. Title Bar
          Container(
            height: 35,
            decoration: const BoxDecoration(
              color: Color(0xFF323233),
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
                      style: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 12),
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
                  width: 50,
                  color: const Color(0xFF333333),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Icon(Icons.file_copy_outlined, color: Colors.white, size: 28),
                      const SizedBox(height: 24),
                      const Icon(Icons.search, color: Colors.white54, size: 28),
                      const SizedBox(height: 24),
                      const Icon(Icons.account_tree_outlined, color: Colors.white54, size: 28),
                      const Spacer(),
                      const Icon(Icons.settings_outlined, color: Colors.white54, size: 24),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                
                // Sidebar
                if (!widget.isMobile)
                  Container(
                    width: 250,
                    color: const Color(0xFF252526),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                          child: Text('EXPLORER', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                          child: Row(
                            children: [
                              Icon(Icons.keyboard_arrow_down, color: Colors.white.withValues(alpha: 0.8), size: 16),
                              const SizedBox(width: 4),
                              Text('PORTFOLIO_WORKSPACE', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        ...files.asMap().entries.map((e) {
                          bool isActive = e.key == activeIndex;
                          String ext = e.value.split('.').last;
                          Color iconColor = _getFileColor(ext);
                          IconData iconData = _getFileIcon(ext);
                          
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => setState(() => activeIndex = e.key),
                              child: Container(
                                color: isActive ? const Color(0xFF37373D) : Colors.transparent,
                                padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 4.0),
                                child: Row(
                                  children: [
                                    Icon(iconData, color: iconColor, size: 16),
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
                          height: 35,
                          color: const Color(0xFF252526),
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
                                    Icon(_getFileIcon(files[activeIndex].split('.').last), color: _getFileColor(files[activeIndex].split('.').last), size: 14),
                                    const SizedBox(width: 8),
                                    Container(
                                      constraints: const BoxConstraints(maxWidth: 150),
                                      child: Text(
                                        files[activeIndex],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Icon(Icons.close, color: Colors.white54, size: 14),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              if (activeIndex != 0)
                                IconButton(
                                  icon: const Icon(Icons.play_arrow, color: Colors.greenAccent, size: 20),
                                  onPressed: _runProject,
                                  tooltip: 'Run Project',
                                ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                        
                        // Breadcrumbs
                        Container(
                          height: 22,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text('portfolio_workspace', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                              Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.6), size: 16),
                              Text('projects', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                              Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.6), size: 16),
                              Expanded(
                                child: Text(
                                  files[activeIndex],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Code Content
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _buildFileContent(activeIndex),
                            ),
                          ),
                        ),
                        
                        // Panel / Terminal
                        if (isPanelOpen)
                          Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              border: Border(top: BorderSide(color: Color(0xFF333333))),
                              color: Color(0xFF1E1E1E),
                            ),
                            child: Column(
                              children: [
                                // Panel Header
                                Container(
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      const Text('PROBLEMS', style: TextStyle(color: Colors.white54, fontSize: 11)),
                                      const SizedBox(width: 20),
                                      const Text('OUTPUT', style: TextStyle(color: Colors.white54, fontSize: 11)),
                                      const SizedBox(width: 20),
                                      const Text('DEBUG CONSOLE', style: TextStyle(color: Colors.white54, fontSize: 11)),
                                      const SizedBox(width: 20),
                                      const Text('TERMINAL', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: Colors.blueAccent, decorationThickness: 2)),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.close, color: Colors.white54, size: 16),
                                        onPressed: () => setState(() => isPanelOpen = false),
                                      ),
                                    ],
                                  ),
                                ),
                                // Panel Body
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
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
            height: 24,
            color: Colors.blue[700],
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.call_split, color: Colors.white, size: 14),
                const SizedBox(width: 4),
                const Text('main*', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(width: 16),
                const Icon(Icons.error_outline, color: Colors.white, size: 14),
                const SizedBox(width: 4),
                const Text('0', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(width: 8),
                const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 14),
                const SizedBox(width: 4),
                const Text('0', style: TextStyle(color: Colors.white, fontSize: 12)),
                const Spacer(),
                const Text('Ln 1, Col 1', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(width: 16),
                const Text('Spaces: 2', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(width: 16),
                const Text('UTF-8', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(width: 16),
                Text(_getLanguage(files[activeIndex]), style: const TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(width: 16),
                const Icon(Icons.notifications_none, color: Colors.white, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
