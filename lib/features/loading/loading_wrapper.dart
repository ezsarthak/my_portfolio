import 'package:flutter/material.dart';
import 'package:portfolio/features/loading/loading_screen.dart';
import 'package:portfolio/home_page.dart';

class LoadingWrapper extends StatefulWidget {
  const LoadingWrapper({super.key});

  @override
  State<LoadingWrapper> createState() => _LoadingWrapperState();
}

class _LoadingWrapperState extends State<LoadingWrapper> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: _isLoading 
          ? LoadingScreen(onComplete: () => setState(() => _isLoading = false))
          : const HomePage(),
    );
  }
}
