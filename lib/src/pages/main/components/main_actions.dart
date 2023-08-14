import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/core/state/navigation_rail/navigation_rail_cubit.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/restaurant_actions/restaurant_actions_view.dart';

class MainActions extends StatelessWidget {
  const MainActions({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        context.select((NavigationRailCubit cubit) => cubit.state.currentIndex);
    switch (currentIndex) {
      case 0:
        return const RestaurantsActionsView();
      default:
        return const EmptyView();
    }
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
