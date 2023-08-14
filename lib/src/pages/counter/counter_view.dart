import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/context_extension.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/theme_extension.dart';
import 'package:papa_burger_admin_panel/src/pages/counter/state/counter_bloc.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_scaffold.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc()..add(const CounterStarted()),
      child: CustomScaffold(
        body: Container(
          color: context.scaffolBackgroundColor,
          width: context.width,
          height: context.height,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterText(),
              ConnectionText(),
            ],
          ),
        ),
        floatingActionButton: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IncrementButton(),
            SizedBox(height: 8),
            DecrementButton(),
          ],
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.select((CounterBloc bloc) => bloc.state.count);
    return KText(
      '$count',
      size: 18,
      fontWeight: FontWeight.bold,
    );
  }
}

class ConnectionText extends StatelessWidget {
  const ConnectionText({super.key});

  @override
  Widget build(BuildContext context) {
    final connection = context.select((CounterBloc bloc) => bloc.state.status);
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

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isConnected = context.select(
      (CounterBloc bloc) => bloc.state.status == ConnectionStatus.connected,
    );
    return FloatingActionButton(
      onPressed: isConnected
          ? () {
              context.read<CounterBloc>().add(const CounterIncrementPressed());
            }
          : null,
      child: const Icon(Icons.add),
    );
  }
}

class DecrementButton extends StatelessWidget {
  const DecrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isConnected = context.select(
      (CounterBloc bloc) => bloc.state.status == ConnectionStatus.connected,
    );
    return FloatingActionButton(
      onPressed: isConnected
          ? () {
              context.read<CounterBloc>().add(const CounterDecrementPressed());
            }
          : null,
      child: const Icon(Icons.remove),
    );
  }
}
