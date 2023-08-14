import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/context_extension.dart';

extension ThemeExtension on BuildContext {
  Color get scaffolBackgroundColor => theme.scaffoldBackgroundColor;
}
