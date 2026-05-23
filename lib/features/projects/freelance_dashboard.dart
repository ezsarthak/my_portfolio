import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class FreelanceDashboard extends StatefulWidget {
  final List<Map<String, dynamic>> projects;
  final bool isMobile;
  
  const FreelanceDashboard({super.key, required this.projects, required this.isMobile});

  @override
  State<FreelanceDashboard> createState() => _FreelanceDashboardState();
}

class _FreelanceDashboardState extends State<FreelanceDashboard> {
  int selectedIndex = 0;
  String activeTab = 'Deliverables';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D12), // Deep SaaS background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 15))
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          // CRM Sidebar
          if (!widget.isMobile)
            Container(
              width: 240,
              decoration: const BoxDecoration(
                color: Color(0xFF15151E),
                border: Border(right: BorderSide(color: Colors.white12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workspace Header
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.purple.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.business_center, color: AppColors.purple, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Client CRM',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Nav Items
                  _buildNavTab('Overview', Icons.dashboard_outlined),
                  _buildNavTab('Deliverables', Icons.task_alt),
                  _buildNavTab('Invoices', Icons.receipt_long_outlined),
                  _buildNavTab('Clients', Icons.people_outline),
                  
                  const Spacer(),
                  
                  // Storage / Plan info (UI flair)
                  Container(
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Freelance Success Rate', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 8),
                        const Text('100%', style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Colors.white12,
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 8),
                        const Text('All contracts delivered', style: TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
          // Main Dashboard Area
          Expanded(
            child: Container(
              color: const Color(0xFF0D0D12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white12)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          activeTab,
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.search, color: Colors.white54, size: 18),
                              SizedBox(width: 8),
                              Text('Search contracts...', style: TextStyle(color: Colors.white54, fontSize: 13)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.purple,
                          child: const Text('SP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  
                  // Content Area (Split between Table and Details)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Contracts List
                        Expanded(
                          flex: 3,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(32),
                            itemCount: widget.projects.length,
                            itemBuilder: (context, index) {
                              var project = widget.projects[index];
                              bool isSelected = index == selectedIndex;
                              
                              return GestureDetector(
                                onTap: () => setState(() => selectedIndex = index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF1A1A24) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: isSelected ? AppColors.purple : Colors.white12),
                                    boxShadow: isSelected ? [BoxShadow(color: AppColors.purple.withOpacity(0.1), blurRadius: 20)] : [],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isSelected ? AppColors.purple.withOpacity(0.2) : Colors.white12,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.description_outlined, color: isSelected ? AppColors.purple : Colors.white54, size: 24),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              project['title'],
                                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Client: ${project['client']}',
                                              style: const TextStyle(color: Colors.white54, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.greenAccent.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
                                            ),
                                            child: const Text('DELIVERED', style: TextStyle(color: Colors.greenAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text('Paid in Full', style: TextStyle(color: Colors.white38, fontSize: 12)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        
                        // Contract Details Panel
                        if (!widget.isMobile)
                          Container(
                            width: 1,
                            color: Colors.white12,
                          ),
                        if (!widget.isMobile && widget.projects.isNotEmpty)
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: const Color(0xFF15151E),
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Project Brief', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                                          const SizedBox(height: 16),
                                          Text(
                                            widget.projects[selectedIndex]['title'],
                                            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 24),
                                          
                                          // Client Info Box
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF1E1E2A),
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.white12),
                                            ),
                                            child: Row(
                                              children: [
                                                const CircleAvatar(
                                                  backgroundColor: Colors.white12,
                                                  child: Icon(Icons.person, color: Colors.white54),
                                                ),
                                                const SizedBox(width: 16),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Client', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                                    Text(widget.projects[selectedIndex]['client'], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          
                                          const SizedBox(height: 32),
                                          const Text('Requirements Delivered', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 16),
                                          Text(
                                            widget.projects[selectedIndex]['description'],
                                            style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.6),
                                          ),
                                          
                                          const SizedBox(height: 32),
                                          const Text('Contract Timeline', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 16),
                                          
                                          // Fake timeline for realism
                                          _buildTimelineItem(Icons.handshake, 'Contract Signed', 'Requirements gathered and deposit received.', true),
                                          _buildTimelineItem(Icons.code, 'Development Phase', 'Core features implemented and tested.', true),
                                          _buildTimelineItem(Icons.check_circle, 'Final Delivery', 'Source code handed over and deployed.', true),
                                          const SizedBox(height: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.purple,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      child: const Text('View Invoice', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ).animate(key: ValueKey(selectedIndex)).fadeIn(duration: 300.ms).slideX(begin: 0.1),
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
    );
  }

  Widget _buildTimelineItem(IconData icon, String title, String subtitle, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.greenAccent.withOpacity(0.1) : Colors.white12,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isCompleted ? Colors.greenAccent : Colors.white54, size: 16),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: isCompleted ? Colors.white : Colors.white54, fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTab(String title, IconData icon) {
    bool isActive = title == activeTab;
    return GestureDetector(
      onTap: () => setState(() => activeTab = title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isActive ? AppColors.purple : Colors.transparent,
              width: 4,
            ),
          ),
          color: isActive ? Colors.white.withOpacity(0.05) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? AppColors.purple : Colors.white54, size: 20),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white54,
                fontSize: 15,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
