import 'package:material_ui/material_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:perplexed/theme/colors.dart';

// flutter_markdown reads flutter/material's Theme, not material_ui's; can't see app theme
// define colors explicitly here
class AppMarkdownStyle {
  static const _text = TextStyle(color: AppColors.whiteColor);

  static final sheet = MarkdownStyleSheet(
    p: _text.copyWith(fontSize: 16),
    h1: _text.copyWith(fontSize: 28),
    h2: _text.copyWith(fontSize: 22),
    h3: _text.copyWith(fontSize: 18),
    listBullet: _text,
    strong: const TextStyle(fontWeight: FontWeight.bold),
    a: const TextStyle(color: AppColors.submitButton),
    code: const TextStyle(fontSize: 16),
    codeblockDecoration: BoxDecoration(
      color: AppColors.cardColor,
      borderRadius: BorderRadius.circular(10),
    ),
    tableHead: _text.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
    tableBody: _text.copyWith(fontSize: 16),
    tableBorder: TableBorder.all(color: AppColors.searchBarBorder),
    tableCellsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}
