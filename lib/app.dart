import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/core/state/navigation_rail/navigation_rail_cubit.dart';
import 'package:papa_burger_admin_panel/src/pages/login/state/login_cubit.dart';
import 'package:papa_burger_admin_panel/src/pages/main/main_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => NavigationRailCubit()),
      ],
      child: const MainView(),
    );
  }
}
