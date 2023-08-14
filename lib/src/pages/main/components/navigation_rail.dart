import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/core/state/navigation_rail/navigation_rail_cubit.dart';

class MainNavigationRail extends StatelessWidget {
  const MainNavigationRail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationRailCubit, NavigationRailState>(
      builder: (context, state) {
        final cubit = context.read<NavigationRailCubit>();
        final currentIndex = cubit.state.currentIndex;
        return NavigationRail(
          selectedIndex: currentIndex,
          onDestinationSelected: cubit.onNavigation,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.table_restaurant_rounded),
              label: Text('Restaurants'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.menu),
              label: Text('Menu'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.star_border),
              selectedIcon: Icon(Icons.star),
              label: Text('Places'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.notifications),
              label: Text('Notifications'),
            ),
          ],
        );
      },
    );
  }
}
