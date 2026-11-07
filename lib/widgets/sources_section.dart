import 'package:material_ui/material_ui.dart';
import 'package:perplexed/services/chat_web_service.dart';
import 'package:perplexed/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

class SourcesSection extends StatefulWidget {
  const new({super.key});

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  bool isLoading = true;
  final _subs = <StreamSubscription>[];
  List searchResults = [
    {'title': 'Google', 'url': 'https://google.com'},
    {'title': 'YouTube', 'url': 'https://youtube.com'},
    {'title': 'Facebook', 'url': 'https://facebook.com'},
  ];

  @override
  void initState() {
    super.initState();
    final chat = ChatWebService();
    _subs.add(
      chat.searchResultStream.listen((data) {
        if (!mounted) return;
        setState(() {
          searchResults = data['data'] as List;
          isLoading = false;
        });
      }),
    );
    _subs.add(
      chat.statusStream.listen((data) {
        if (!mounted || data['type'] != 'error') return;
        setState(() {
          searchResults = [];
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
        Row(
          children: [
            Icon(Icons.source_outlined, color: Colors.white70),
            SizedBox(width: 8),
            Text(
              "Sources",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Skeletonizer(
          enabled: isLoading,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: searchResults.map((res) {
              return Container(
                width: 150,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      res['title'],
                      style: TextStyle(fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => launchUrl(
                          Uri.parse(res['url']),
                          webOnlyWindowName: '_blank',
                        ),
                        child: Text(
                          res['url'],
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
/*
architecture

-> 
*/
