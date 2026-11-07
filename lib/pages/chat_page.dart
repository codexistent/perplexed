import 'package:material_ui/material_ui.dart';
import 'package:perplexed/theme/colors.dart';
import 'package:perplexed/widgets/answer_section.dart';
import 'package:perplexed/widgets/side_bar.dart';
import 'package:perplexed/widgets/sources_section.dart';

class ChatPage extends StatelessWidget {
  final String question;
  const ChatPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          const SizedBox(width: 100),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // header
                    Text(
                      question,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),

                    // sources
                    SourcesSection(),

                    // output content section
                    AnswerSection(),
                  ],
                ),
              ),
            ),
          ),
          Placeholder(strokeWidth: 0, color: AppColors.background),
        ],
      ),
    );
  }
}
