import 'package:flutter/widgets.dart';
import 'package:perplexed/theme/colors.dart';

class FooterLink extends StatelessWidget {
  final String footerText;
  const FooterLink({super.key, required this.footerText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        footerText,
        style: TextStyle(fontSize: 14, color: AppColors.footerGrey),
      ),
    );
  }
}
