import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/config/constants/padding.dart';
import 'package:papa_burger_admin_panel/src/config/constants/radius.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

SnackBar customSnackBar(
  String text, {
  String? solution,
  bool dismissible = true,
  Color color = Colors.white,
  Duration duration = const Duration(seconds: 4),
  SnackBarBehavior? behavior,
  SnackBarAction? snackBarAction,
  DismissDirection dismissDirection = DismissDirection.down,
}) {
  return SnackBar(
    dismissDirection: dismissible ? dismissDirection : DismissDirection.none,
    action: snackBarAction,
    duration: duration,
    behavior: behavior ?? SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defaultBorderRadius),
    ),
    margin: const EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
    content: solution == null
        ? KText(
            text,
            color: color,
          )
        : Column(
            children: [
              KText(
                text,
                color: color,
              ),
              KText(
                solution,
                color: Colors.grey.shade300,
                size: 14,
              ),
            ],
          ),
  );
}
