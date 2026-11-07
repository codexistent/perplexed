import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:perplexed/theme/colors.dart';
import 'package:perplexed/widgets/side_bar.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (kIsWeb) const SideBar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class PageLayout extends StatelessWidget {
  final List<Widget> children;
  const PageLayout({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Row(
        children: [
          if (kIsWeb) const SizedBox(width: kIsWeb ? 100 : 0),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
          ),
          if (kIsWeb) Placeholder(strokeWidth: 0, color: AppColors.background),
        ],
      ),
    );
  }
}
