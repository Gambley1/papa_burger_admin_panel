import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/models/restaurant/restaurant.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/restaurant_actions/components/add_restaurant_view.dart';
import 'package:papa_burger_admin_panel/src/pages/main/components/restaurant_actions/components/update_restaurant_view.dart';
import 'package:papa_burger_admin_panel/src/pages/main/main_view.dart';

extension NavigatorExtension on BuildContext {
  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  void navigateToMainPage() {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute<MainView>(
        builder: (context) => const MainView(),
      ),
    );
  }

  void navigateToAddRestaurantView() {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute<dynamic>(
        builder: (context) => const AddRestaurantView(),
      ),
      (route) => true,
    );
  }

  Future<bool?> navigateToUpdateRestaurantView({
    required String placeId,
    required String name,
    required List<Tag> tags,
    required String imageUrl,
    required double rating,
    required double latitude,
    required double longitude,
    int? userRatingsTotal,
  }) async {
    final result = await Navigator.pushAndRemoveUntil<bool?>(
      this,
      MaterialPageRoute<bool?>(
        builder: (context) => UpdateRestaurantView(
          placeId: placeId,
          name: name,
          tags: tags,
          imageUrl: imageUrl,
          rating: rating,
          userRatingsTotal: userRatingsTotal,
          latitude: latitude,
          longitude: longitude,
        ),
      ),
      (route) => true,
    );
    return result;
  }
}
