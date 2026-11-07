import 'package:material_ui/material_ui.dart';
import 'package:perplexed/widgets/page_layout.dart';

class CareersPage extends StatelessWidget {
  const CareersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      children: [
        Text(
          "Coming Soon...",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
