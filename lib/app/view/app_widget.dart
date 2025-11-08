import 'package:flutter/material.dart';
import 'package:calculator/app/core/theme/app_theme.dart';
import 'package:calculator/features/calculator/view/calculator_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}
