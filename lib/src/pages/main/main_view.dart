import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/main_actions.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/navigation_rail.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_scaffold.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      withSafeArea: true,
      body: Row(
        children: [
          MainNavigationRail(),
          MainActions(),
        ],
      ),
    );
  }
}
