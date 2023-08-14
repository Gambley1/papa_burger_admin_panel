import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/main_actions.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/navigation_rail.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_scaffold.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      withSafeArea: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          if (maxWidth <= 560) {
            return const MobileScreen();
          }
          return const WebScreen();
        },
      ),
    );
  }
}

class WebScreen extends StatelessWidget {
  const WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        MainNavigationRail(),
        MainActions(),
      ],
    );
  }
}

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        MainNavigationRail(),
        MainActions(),
      ],
    );
  }
}
