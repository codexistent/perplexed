import 'package:material_ui/material_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:perplexed/theme/markdown_style.dart';

class AnswerSection extends StatefulWidget {
  const new({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  String fullResponse = '''
Temporary

Test

String
''';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Perplexity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        Markdown(
          data: fullResponse,
          shrinkWrap: true,
          styleSheet: AppMarkdownStyle.sheet,
        ),
      ],
    );
  }
}
