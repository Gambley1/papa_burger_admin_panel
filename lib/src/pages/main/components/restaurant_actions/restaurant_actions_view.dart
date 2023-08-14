import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/config/constants/padding.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/snack_bar_extension.dart';
import 'package:papa_burger_admin_panel/src/config/utils/logger.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/restaurant_actions/components/add_restaurant_view.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/restaurant_actions/components/restaurants_list_view.dart';
import 'package:papa_burger_admin_panel/src/pages/main/state/restaurants_actions/restaurants_actions_cubit.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

class RestaurantsActionsView extends StatefulWidget {
  const RestaurantsActionsView({super.key});

  @override
  State<RestaurantsActionsView> createState() => _RestaurantsActionsViewState();
}

class _RestaurantsActionsViewState extends State<RestaurantsActionsView> {
  @override
  void initState() {
    super.initState();
    context.read<RestaurantsActionsCubit>().getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AddRestaurantText(),
          RestaurantsListView(),
        ],
      ),
    );
  }
}

class AddRestaurantText extends StatelessWidget {
  const AddRestaurantText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const KText(
            'Add new restaurant.',
            size: 22,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            width: 24,
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            onPressed: () async {
              final result = await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<String?>(
                  builder: (context) => const AddRestaurantView(),
                ),
                (route) => true,
              );
              if (result != null) {
                logger.i('Updating.');
                await Future.microtask(() {
                  context.showSnackBar(result);
                  context.read<RestaurantsActionsCubit>().getRestaurants();
                });
              }
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
