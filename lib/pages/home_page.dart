import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:perplexed/services/chat_web_service.dart';
import 'package:perplexed/widgets/footer_link.dart';
import 'package:perplexed/widgets/search_section.dart';
import 'package:perplexed/widgets/side_bar.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // connect to websocket
    ChatWebService().connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          kIsWeb ? SideBar() : SizedBox(),

          Expanded(
            child: Padding(
              padding: kIsWeb ? EdgeInsets.all(8.0) : EdgeInsets.zero,
              child: Column(
                children: [
                  Expanded(child: SearchSection()),

                  // footer
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        FooterLink(footerText: "Pro"),
                        FooterLink(footerText: "Store"),
                        FooterLink(footerText: "Blog"),
                        FooterLink(footerText: "Careers"),
                        FooterLink(footerText: "English (English)"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
