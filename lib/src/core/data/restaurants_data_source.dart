import 'package:papa_burger_admin_panel/src/models/menu/menu.dart';
import 'package:papa_burger_admin_panel/src/models/restaurant/restaurant.dart';

abstract class RestaurantsDataSource {
  Future<String> addRestaurant(
    String placeId, {
    required String name,
    required double rating,
    required int userRatingsTotal,
    required double latitude,
    required double longitude,
    String tags = 'Fast Food',
    String imageUrl = '',
  });

  Future<List<Restaurant>> getRestaurants();

  Future<String> updateRestaurant(
    String placeId, {
    String? name,
    double? rating,
    int? userRatingsTotal,
    double? latitude,
    double? longitude,
    String? tags,
    String? imageUrl,
  });

  Future<String> deleteRestaurant(String placeId);

  Future<List<Menu>> getRestaurantMenu(String placeId);
}
