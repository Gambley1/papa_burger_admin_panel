import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/pages/main/main_view.dart';

extension NavigatorExtension on BuildContext {
  void navigateToMainPage() {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute<MainView>(
        builder: (context) => const MainView(),
      ),
    );
  }
}
