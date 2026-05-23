import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/design/utils/app_colors.dart';
import 'package:portfolio/design/widgets/buttons/app_outlined_button.dart';

class NodeGraphProjectGallery extends StatefulWidget {
  final List<Map<String, dynamic>> projects;
  final bool isMobile;
  const NodeGraphProjectGallery({super.key, required this.projects, required this.isMobile});

  @override
  State<NodeGraphProjectGallery> createState() => _NodeGraphProjectGalleryState();
}

class _NodeGraphProjectGalleryState extends State<NodeGraphProjectGallery> {
  int? activeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.purpleDark.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
      ),
      child: Stack(
        children: [
          // The Nodes
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cx = constraints.maxWidth / (widget.isMobile ? 2 : 3);
                double cy = constraints.maxHeight / 2;
                
                List<Offset> positions = [
                  Offset(cx - 100, cy - 80),
                  Offset(cx + 100, cy - 120),
                  Offset(cx - 80, cy + 100),
                  Offset(cx + 120, cy + 80),
                ];
                
                return Stack(
                  children: [
                    CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter: _GraphPainter(positions, AppColors.purple.withValues(alpha: 0.3)),
                    ),
                    ...widget.projects.asMap().entries.map((entry) {
                      int idx = entry.key;
                      Offset pos = positions[idx % positions.length];
                      bool isActive = activeIndex == idx;
                      
                      return Positioned(
                        left: pos.dx - 40,
                        top: pos.dy - 40,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => setState(() => activeIndex = idx),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: isActive ? 100 : 80,
                              height: isActive ? 100 : 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive ? AppColors.purple : AppColors.purpleDark,
                                border: Border.all(color: AppColors.violet, width: isActive ? 3 : 1),
                                boxShadow: isActive ? [BoxShadow(color: AppColors.purple.withValues(alpha: 0.6), blurRadius: 20)] : [],
                              ),
                              child: Center(
                                child: Text(
                                  widget.projects[idx]['title']!.substring(0, 1),
                                  style: TextStyle(fontSize: isActive ? 36 : 24, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
          
          if (activeIndex != null && !widget.isMobile)
            Positioned(
              right: 20,
              top: 20,
              bottom: 20,
              width: 300,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.purpleDark.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.hub, color: AppColors.violet),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white54),
                          onPressed: () => setState(() => activeIndex = null),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.projects[activeIndex!]['title']!,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.projects[activeIndex!]['description']!,
                      style: const TextStyle(color: Colors.white70, height: 1.5),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (widget.projects[activeIndex!]['tech'] as List<dynamic>? ?? []).map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.purpleDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(t.toString(), style: const TextStyle(color: Colors.white, fontSize: 11)),
                      )).toList(),
                    ),
                    const SizedBox(height: 20),
                    AppOutlinedButton(
                      title: 'CONNECT NODE',
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2),
            ),
            
            if (activeIndex != null && widget.isMobile)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.purpleDark.withValues(alpha: 0.95),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    border: Border(top: BorderSide(color: AppColors.purple)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.projects[activeIndex!]['title']!,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white54),
                            onPressed: () => setState(() => activeIndex = null),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.projects[activeIndex!]['description']!,
                        style: const TextStyle(color: Colors.white70, height: 1.4),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ).animate().slideY(begin: 1.0, duration: 300.ms),
              ),
        ],
      ),
    );
  }
}

class _GraphPainter extends CustomPainter {
  final List<Offset> positions;
  final Color lineColor;

  _GraphPainter(this.positions, this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        canvas.drawLine(positions[i], positions[j], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
