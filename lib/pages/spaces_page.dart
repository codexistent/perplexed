import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:perplexed/theme/colors.dart';
import 'package:perplexed/widgets/side_bar.dart';

class SpacesPage extends StatelessWidget {
  const SpacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          kIsWeb ? SideBar() : SizedBox(),
          const SizedBox(width: kIsWeb ? 100 : 0),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // header
                    Text(
                      "Coming Soon...",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          kIsWeb
              ? Placeholder(strokeWidth: 0, color: AppColors.background)
              : SizedBox(),
        ],
      ),
    );
  }
}
