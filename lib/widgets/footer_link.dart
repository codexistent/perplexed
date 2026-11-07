import 'package:material_ui/material_ui.dart';
import 'package:perplexed/pages/careers_page.dart';
import 'package:perplexed/pages/pro_page.dart';
import 'package:perplexed/pages/store_page.dart';
import 'package:perplexed/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterLink extends StatelessWidget {
  final String footerText;
  // final String? url;
  const FooterLink({super.key, required this.footerText /*, this.url*/});

  @override
  Widget build(BuildContext context) {
    // TODO: remove hardcoding for these links
    return GestureDetector(
      onTap: () {
        final nav = Navigator.of(context);
        if (footerText == "Pro") {
          nav.popUntil((route) => route.isFirst);
          nav.push(MaterialPageRoute(builder: (_) => const ProPage()));
        }
        if (footerText == "Store") {
          nav.popUntil((route) => route.isFirst);
          nav.push(MaterialPageRoute(builder: (_) => const StorePage()));
        }
        if (footerText == "Blog") {
          launchUrl(
            Uri.parse("https://codexistent.github.io/"),
            webOnlyWindowName: '_blank',
          );
        }
        if (footerText == "Careers") {
          nav.popUntil((route) => route.isFirst);
          nav.push(MaterialPageRoute(builder: (_) => const CareersPage()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          footerText,
          style: TextStyle(fontSize: 14, color: AppColors.footerGrey),
        ),
      ),
    );

    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 12),
    //   child: MouseRegion(
    //     cursor: url != null ? SystemMouseCursors.click : MouseCursor.defer,
    //     child: GestureDetector(
    //       onTap: url == null
    //           ? null
    //           : () => launchUrl(Uri.parse(url!), webOnlyWindowName: '_blank'),
    //       child: Text(
    //         footerText,
    //         style: TextStyle(fontSize: 14, color: AppColors.footerGrey),
    //       ),
    //     ),
    //   ),
    // );
  }
}
