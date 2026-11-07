import 'package:material_ui/material_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:perplexed/services/chat_web_service.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

class AnswerSection extends StatefulWidget {
  const new({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  bool isLoading = true;
  final _subs = <StreamSubscription>[];
  String fullResponse = '''
This is an example/placeholder response. You can put anything here, such as:
- avocadoes
- oranges
- mongoes
- potatoes

and more, such as lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil.

lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil excepteur ea ducimus praesentium similique aliquip voluptatum rerum distinctio id distinctio fuga veniam qui officia exercitation corrupti ducimus cupiditate sed possimus omnis quo similique dolore officia nobis cumque quidem provident et expedita non vel esse ea imperdiet facilis nulla. lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil excepteur.

lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil excepteur.

lorem ipsum dolor sit amet consectetur adipiscing elit est cupidatat nihil excepteur ea ducimus praesentium similique aliquip voluptatum rerum distinctio id distinctio fuga veniam.
  ''';

  @override
  void initState() {
    super.initState();
    final chat = ChatWebService();
    _subs.add(
      chat.contentStream.listen((data) {
        if (!mounted) return;
        setState(() {
          if (isLoading) fullResponse = "";
          fullResponse += data['data'];
          isLoading = false;
        });
      }),
    );
    _subs.add(
      chat.statusStream.listen((data) {
        if (!mounted || data['type'] != 'error') return;
        setState(() {
          fullResponse = data['data'];

          isLoading = false;
        });
      }),
    );
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Perplexed',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        Skeletonizer(
          enabled: isLoading,
          child: MarkdownBody(
            data: fullResponse,
            shrinkWrap: true,
            onTapLink: (text, href, title) {
              if (href != null) {
                launchUrl(
                  Uri.parse(href),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
