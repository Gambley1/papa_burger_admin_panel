import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/config/constants/padding.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/context_extension.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/theme_extension.dart';
import 'package:papa_burger_admin_panel/src/pages/login/components/login_form.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_scaffold.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      withReleaseFocus: true,
      body: Container(
        height: context.height,
        width: context.width,
        color: context.scaffolBackgroundColor,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
