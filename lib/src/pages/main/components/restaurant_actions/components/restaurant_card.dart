import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/config/constants/padding.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/dialog_extension.dart';
import 'package:papa_burger_admin_panel/src/pages/main/state/restaurants_actions/restaurants_actions_cubit.dart';
import 'package:papa_burger_admin_panel/src/widgets/cached_image.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    required this.imageUrl,
    required this.name,
    required this.deleteRestaurant,
    required this.isDeleting,
    required this.navigateToUpdateRestaurant,
    super.key,
  });

  final String imageUrl;
  final String name;
  final bool isDeleting;
  final Future<void> Function() deleteRestaurant;
  final Future<bool?> Function() navigateToUpdateRestaurant;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantsActionsCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImage(
            imageUrl: imageUrl,
            height: 120,
            width: 400,
            imageType: CacheImageType.smallImageWithNoShimmer,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LimitedBox(
                maxWidth: 170,
                child: KText(
                  name,
                  size: 20,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                width: 48,
              ),
              TextButton.icon(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final result = await navigateToUpdateRestaurant();
                  if (result != null && result == true) {
                    await cubit.getRestaurants();
                  }
                },
                label: const KText(
                  'Edit',
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  final result = await context.showConfirmationDialog();
                  if (result != null && result == true) {
                    await deleteRestaurant();
                  }
                },
                icon: isDeleting
                    ? Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                label: const KText(
                  'Delete',
                  color: Colors.red,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
