import 'package:flutter/material.dart';
import 'package:perplexed/pages/home_page.dart';
import 'package:perplexed/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
      home: const HomePage(),
    );
  }
}
