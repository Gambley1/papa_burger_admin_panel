import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/config/constants/padding.dart';
import 'package:papa_burger_admin_panel/src/pages/login/components/login_form.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_scaffold.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      withSafeArea: true,
      withReleaseFocus: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
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
