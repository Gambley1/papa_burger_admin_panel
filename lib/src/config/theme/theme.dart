import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papa_burger_admin_panel/src/config/constants/colors.dart';
import 'package:papa_burger_admin_panel/src/config/constants/radius.dart';

class AppTheme {
  const AppTheme();

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: kPrimaryBackgrounColor,
    colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
    useMaterial3: true,
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: kPrimaryNavigationRailBackgroundColor,
      elevation: 2,
      labelType: NavigationRailLabelType.all,
      unselectedLabelTextStyle: TextStyle(
        color: Colors.white.withOpacity(.4),
      ),
      selectedLabelTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(kPrimaryButtonColor),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
        ),
      ),
    ),
  );
}

class SystemUiOverlayTheme {
  const SystemUiOverlayTheme();

  static SystemUiOverlayStyle mainOverlayStyle = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: kPrimaryStatusBarColor,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: kPrimarySystemNavigationBarColor,
    systemNavigationBarDividerColor: kPrimarySystemNavigationBarDividerColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
