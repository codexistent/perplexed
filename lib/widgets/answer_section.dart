import 'package:material_ui/material_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:perplexed/services/chat_web_service.dart';
import 'package:perplexed/theme/markdown_style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnswerSection extends StatefulWidget {
  const new({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  bool isLoading = true;
  String fullResponse = '''
lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil excepteur ea ducimus praesentium similique aliquip voluptatum rerum distinctio id distinctio fuga veniam qui officia exercitation corrupti ducimus cupiditate sed possimus omnis quo similique dolore officia nobis cumque quidem provident et expedita non vel esse ea imperdiet facilis nulla

lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil excepteur ea ducimus praesentium similique aliquip voluptatum rerum distinctio id distinctio fuga veniam qui officia exercitation corrupti ducimus cupiditate sed possimus omnis quo similique dolore officia nobis cumque quidem provident et expedita non vel esse ea imperdiet facilis nulla

lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil excepteur ea ducimus praesentium similique aliquip voluptatum rerum distinctio id distinctio fuga veniam qui officia exercitation corrupti ducimus cupiditate sed possimus omnis quo similique dolore officia nobis cumque quidem provident et expedita non vel esse ea imperdiet facilis nulla

lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil excepteur ea ducimus praesentium similique aliquip voluptatum rerum distinctio id distinctio fuga veniam qui officia exercitation corrupti ducimus cupiditate sed possimus omnis quo similique dolore officia nobis cumque quidem provident et expedita non vel esse ea imperdiet facilis nulla
  ''';

  @override
  void initState() {
    super.initState();
    ChatWebService().contentStream.listen((data) {
      // clear string on first time
      if (isLoading) fullResponse = "";

      setState(() {
        fullResponse += data['data'];
        isLoading = false;
      });
    });
  }

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

        Skeletonizer(
          enabled: isLoading,
          child: Markdown(
            data: fullResponse,
            shrinkWrap: true,
            styleSheet: AppMarkdownStyle.sheet,
          ),
        ),
      ],
    );
  }
}
