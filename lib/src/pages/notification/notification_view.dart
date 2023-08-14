import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/context_extension.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/theme_extension.dart';
import 'package:papa_burger_admin_panel/src/pages/counter/state/counter_bloc.dart';
import 'package:papa_burger_admin_panel/src/pages/notification/state/notification_bloc.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_scaffold.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc()..add(const NotificationStarted()),
      child: CustomScaffold(
        body: Container(
          height: context.height,
          width: context.width,
          color: context.scaffolBackgroundColor,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MessageText(),
              ConnectionText(),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageText extends StatelessWidget {
  const MessageText({super.key});

  @override
  Widget build(BuildContext context) {
    final message =
        context.select((NotificationBloc bloc) => bloc.state.message);
    return KText(
      message.isEmpty ? 'No messages yet' : message,
      fontWeight: FontWeight.bold,
      size: 24,
    );
  }
}

class ConnectionText extends StatelessWidget {
  const ConnectionText({super.key});

  @override
  Widget build(BuildContext context) {
    final connection =
        context.select((NotificationBloc bloc) => bloc.state.status);
    switch (connection) {
      case ConnectionStatus.connected:
        return const KText(
          'Connected',
          color: Colors.green,
        );
      case ConnectionStatus.disconnected:
        return const KText(
          'Disconnected',
          color: Colors.red,
        );
    }
  }
}
