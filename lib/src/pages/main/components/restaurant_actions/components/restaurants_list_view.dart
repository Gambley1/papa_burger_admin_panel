import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/navigator_extension.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/snack_bar_extension.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/restaurant_actions/components/restaurant_card.dart';
import 'package:papa_burger_admin_panel/src/pages/main/state/restaurants_actions/restaurants_actions_cubit.dart';

class RestaurantsListView extends StatelessWidget {
  const RestaurantsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsActionsCubit, RestaurantsActionsState>(
      listener: (context, state) {
        final clientFailed = state.clientRequestFailed;
        final malformed = state.malformedResponse;
        final deleteFailure = state.deleteRestaurantFailure;
        final message = state.message;
        if (clientFailed) {
          context.showSnackBar(
            message ?? 'Client request failed. Try again later.',
          );
        }
        if (malformed) {
          context
              .showSnackBar(message ?? 'Malformed response. Try again later.');
        }
        if (deleteFailure) {
          context.showSnackBar(message ?? 'Oops something went wrong.');
        }
      },
      builder: (context, state) {
        final restaurants = state.restaurants;
        final cubit = context.read<RestaurantsActionsCubit>();
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              final name = restaurant.name;
              final imageUrl = restaurant.imageUrl;
              final placeId = restaurant.placeId;
              final tags = restaurant.tags;
              final rating = restaurant.rating;
              final userRatingsTotal = restaurant.userRatingsTotal;
              final latitude = restaurant.latitude;
              final longitude = restaurant.longitude;
              final isDeleting = restaurant.isDeleting;
              return RestaurantCard(
                imageUrl: imageUrl,
                name: name,
                isDeleting: isDeleting,
                navigateToUpdateRestaurant: () =>
                    context.navigateToUpdateRestaurantView(
                  placeId: placeId,
                  name: name,
                  tags: tags,
                  imageUrl: imageUrl,
                  rating: rating as double,
                  userRatingsTotal: userRatingsTotal,
                  latitude: latitude,
                  longitude: longitude,
                ),
                deleteRestaurant: () => cubit.deleteRestaurant(placeId),
              );
            },
            itemCount: restaurants.length,
          ),
        );
      },
    );
  }
}
