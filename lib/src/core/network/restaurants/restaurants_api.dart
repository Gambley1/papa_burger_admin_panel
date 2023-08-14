import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:papa_burger_admin_panel/src/config/utils/logger.dart';
import 'package:papa_burger_admin_panel/src/core/data/restaurants_data_source.dart';
import 'package:papa_burger_admin_panel/src/models/exceptions/exceptions.dart';
import 'package:papa_burger_admin_panel/src/models/menu/menu.dart';
import 'package:papa_burger_admin_panel/src/models/restaurant/restaurant.dart';
import 'package:papa_burger_server/api.dart' as server;

class RestaurantsApi implements RestaurantsDataSource {
  RestaurantsApi({server.HttpClient? httpClient})
      : _httpClient = httpClient ?? server.HttpClient();

  final server.HttpClient _httpClient;

  Uri buildHttpsAdminRestaurantsUrl({
    required String method,
    String? placeId,
    String? name,
    String? tags,
    String? imageUrl,
    String? rating,
    String? userRatingsTotal,
    String? latitude,
    String? longitude,
  }) {
    final post = method == 'post';
    final get = method == 'get';
    final put = method == 'put';
    final delete = method == 'delete';
    String path() {
      if (post) return '/restaurants/create';
      if (get) return '/restaurants/get';
      if (put) return '/restaurants/update';
      if (delete) return '/restaurants/delete';
      throw Exception('Method is not allowed.');
    }

    final noQueryParameters = placeId == null &&
        name == null &&
        tags == null &&
        imageUrl == null &&
        rating == null &&
        userRatingsTotal == null &&
        latitude == null &&
        longitude == null;

    return Uri.https(
      'papa-burger-server-production.up.railway.app',
      path(),
      noQueryParameters
          ? null
          : {
              if (placeId != null) 'place_id': placeId,
              if (name != null) 'name': name,
              if (tags != null) 'tags': tags,
              if (imageUrl != null) 'image_url': imageUrl,
              if (userRatingsTotal != null)
                'user_ratings_total': userRatingsTotal,
              if (latitude != null) 'latitude': latitude,
              if (longitude != null) 'longitude': longitude,
              if (rating != null) 'rating': rating,
            },
    );
  }

  @override
  Future<String> addRestaurant(
    String placeId, {
    required String name,
    required double rating,
    required int userRatingsTotal,
    required double latitude,
    required double longitude,
    String tags = 'Fast Food',
    String imageUrl = '',
  }) async {
    try {
      final url = buildHttpsAdminRestaurantsUrl(
        method: 'post',
        name: name,
        rating: '$rating',
        placeId: placeId,
        userRatingsTotal: '$userRatingsTotal',
        latitude: '$latitude',
        longitude: '$longitude',
        tags: tags,
        imageUrl: imageUrl,
      );
      final response = await http.post(url);
      final message = response.body;
      return jsonDecode(message) as String;
    } catch (e) {
      logger.e(e);
      throw apiExceptionsFormatter(e);
    }
  }

  @override
  Future<List<Restaurant>> getRestaurants() async {
    try {
      final url = buildHttpsAdminRestaurantsUrl(method: 'get');
      final response = await http.get(url);
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final restaurants = data['restaurants'] as List;
      return restaurants
          .map<Restaurant>(
            (e) => Restaurant.fromMap(
              jsonDecode(e as String) as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }
  }

  @override
  Future<String> updateRestaurant(
    String placeId, {
    String? name,
    double? rating,
    int? userRatingsTotal,
    double? latitude,
    double? longitude,
    String? tags,
    String? imageUrl,
  }) async {
    try {
      final url = buildHttpsAdminRestaurantsUrl(
        method: 'put',
        name: name,
        rating: '$rating',
        placeId: placeId,
        userRatingsTotal: '$userRatingsTotal',
        latitude: '$latitude',
        longitude: '$longitude',
        tags: tags,
        imageUrl: imageUrl,
      );
      final response = await http.put(url);
      final message = response.body;
      return jsonDecode(message) as String;
    } catch (e) {
      throw apiExceptionsFormatter(e);
    }
  }

  @override
  Future<String> deleteRestaurant(String placeId) async {
    try {
      final url = buildHttpsAdminRestaurantsUrl(
        method: 'delete',
        placeId: placeId,
      ); 
      final response = await http.delete(url);
      final message = response.body;
      return jsonDecode(message) as String;
    } catch (e) {
      throw apiExceptionsFormatter(e);
    }
  }

  @override
  Future<List<Menu>> getRestaurantMenu(String placeId) async {
    try {
      final menus = await _httpClient.getRestaurantMenu(placeId);
      return menus
          .map(
            (e) =>
                Menu.fromJson(jsonDecode(e as String) as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw apiExceptionsFormatter(e);
    }
  }
}
