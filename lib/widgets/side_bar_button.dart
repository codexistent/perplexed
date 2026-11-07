import 'package:material_ui/material_ui.dart';
import 'package:perplexed/pages/spaces_page.dart';
import 'package:perplexed/theme/colors.dart';

class SideBarButton extends StatelessWidget {
  final bool isCollapsed;
  final IconData icon;
  final String buttonText;
  const SideBarButton({
    super.key,
    required this.isCollapsed,
    required this.icon,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final nav = Navigator.of(context);
        if (buttonText == "Home" || buttonText == "Search") {
          // navigate to home page
          nav.popUntil((route) => route.isFirst);
        }
        if (buttonText == "Spaces") {
          nav.popUntil((route) => route.isFirst);
          nav.push(MaterialPageRoute(builder: (_) => const SpacesPage()));
        }
      },
      child: Row(
        mainAxisAlignment: isCollapsed
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            child: Icon(icon, color: AppColors.iconGrey, size: 22),
          ),
          isCollapsed
              ? const SizedBox()
              : Text(
                  buttonText,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }
}
