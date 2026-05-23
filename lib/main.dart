import 'package:flutter/material.dart';
import 'package:portfolio/config/portfolio_data.dart';
import 'package:portfolio/design/utils/app_theme.dart';
import 'package:portfolio/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      title: '${PortfolioData.name} | Portfolio',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
