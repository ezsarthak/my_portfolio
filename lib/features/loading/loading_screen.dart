import 'package:flutter/material.dart';
import 'package:portfolio/design/utils/app_colors.dart';

class LoadingScreen extends StatefulWidget {
  final VoidCallback onComplete;
  
  const LoadingScreen({super.key, required this.onComplete});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _counterAnimation;

  @override
  void initState() {
    super.initState();
    // Make it fast but not too much: 2.5 seconds
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));
    // Curve makes it start slow and then boom fast
    _counterAnimation = IntTween(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInExpo)
    );
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Brief pause at 100 before fading out
        Future.delayed(const Duration(milliseconds: 400), widget.onComplete);
      }
    });
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    bool isMobile = w < 800;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0e21), // AppTheme bgPrimary
      body: Stack(
        children: [
          // Background subtle wave line
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          
          Positioned(
            left: 0,
            right: 0,
            bottom: isMobile ? 50 : 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: isMobile ? 30 : 80),
                  child: AnimatedBuilder(
                    animation: _counterAnimation,
                    builder: (context, child) {
                      return Text(
                        _counterAnimation.value.toString().padLeft(3, '0'),
                        style: TextStyle(
                          fontFamily: 'Preah',
                          fontSize: isMobile ? 100 : 180,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.0,
                          letterSpacing: -5,
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      height: 2,
                      width: w * _controller.value,
                      color: AppColors.purple,
                    );
                  }
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: isMobile ? 30 : 80),
                  child: Text(
                    'EZSARTHAK.COM / CRAFTED WITH FLUTTER & AI',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: isMobile ? 10 : 12,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
