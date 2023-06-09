import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/core/state/navigation_rail/navigation_rail_cubit.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

class MainActions extends StatelessWidget {
  const MainActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationRailCubit, NavigationRailState>(
      builder: (context, state) {
        final currentIndex = state.currentIndex;
        switch (currentIndex) {
          case 0:
            return const RestaurantsActions();
          case 1:
            return const MenuActions();
          default:
            return const EmptyView();
        }
      },
    );
  }
}

class RestaurantsActions extends StatelessWidget {
  const RestaurantsActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        KText('Restaurants actions'),
      ],
    );
  }
}

class MenuActions extends StatelessWidget {
  const MenuActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        KText('Menu actions'),
      ],
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
