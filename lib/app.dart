import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/config/theme/theme.dart';
import 'package:papa_burger_admin_panel/src/core/state/navigation_rail/navigation_rail_cubit.dart';
import 'package:papa_burger_admin_panel/src/pages/login/state/login_cubit.dart';
import 'package:papa_burger_admin_panel/src/pages/main/main_view.dart';
import 'package:papa_burger_admin_panel/src/pages/main/state/restaurants_actions/restaurants_actions_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => NavigationRailCubit()),
        BlocProvider(create: (context) => RestaurantsActionsCubit()),
      ],
      child: MaterialApp(
        title: 'Papa Burger admin panel',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainView(),
      ),
    );
  }
}
