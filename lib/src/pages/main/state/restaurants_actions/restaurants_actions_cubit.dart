// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papa_burger_admin_panel/src/config/utils/logger.dart';
import 'package:papa_burger_admin_panel/src/core/network/restaurants/restaurants_api.dart';
import 'package:papa_burger_admin_panel/src/models/exceptions/exceptions.dart';
import 'package:papa_burger_admin_panel/src/models/restaurant/restaurant.dart';
import 'package:uuid/uuid.dart';

part 'restaurants_actions_state.dart';

class RestaurantsActionsCubit extends Cubit<RestaurantsActionsState> {
  RestaurantsActionsCubit({
    RestaurantsApi? restaurantsApi,
    Uuid? uuid,
  })  : _restaurantsApi = restaurantsApi ?? RestaurantsApi(),
        _uuid = uuid ?? const Uuid(),
        super(const RestaurantsActionsState.initial());

  final RestaurantsApi _restaurantsApi;
  final Uuid _uuid;

  void onPlaceIdChange(String value) {
    final newState = state.copyWith(
      placeId: value,
    );
    emit(newState);
  }

  void onNameChange(String value) {
    final newState = state.copyWith(
      name: value,
    );
    emit(newState);
  }

  void onImageUrlChange(String value) {
    final newState = state.copyWith(
      imageUrl: value,
    );
    emit(newState);
  }

  void onTagAdd(String value) {
    final tag = Tag(name: value, imageUrl: '');
    if (state.tags.contains(tag)) {
      return;
    }
    final newState = state.copyWith(
      tags: {...state.tags, tag},
    );
    emit(newState);
  }

  void onTagDelete(Tag tag) {
    final newState = state.copyWith(
      tags: {...state.tags}..remove(tag),
    );
    emit(newState);
  }

  void onRatingChange(String value) {
    final newState = state.copyWith(
      rating: double.tryParse(value),
    );
    emit(newState);
  }

  void onUserRatingsTotalChange(String value) {
    final newState = state.copyWith(
      userRatingsTotal: int.tryParse(value),
    );
    emit(newState);
  }

  void onLatitudeChange(String value) {
    final newState = state.copyWith(
      latitude: double.tryParse(value),
    );
    emit(newState);
  }

  void onLongitudeChange(String value) {
    final newState = state.copyWith(
      longitude: double.tryParse(value),
    );
    emit(newState);
  }

  void initRestaurantFields({
    required String placeId,
    required String name,
    required String imageUrl,
    required Set<Tag> tags,
    required double rating,
    required int userRatingsTotal,
    required double latitude,
    required double longitude,
  }) {
    final newState = state.copyWith(
      placeId: placeId,
      name: name,
      imageUrl: imageUrl,
      tags: tags,
      rating: rating,
      userRatingsTotal: userRatingsTotal,
      latitude: latitude,
      longitude: longitude,
    );
    emit(newState);
  }

  void removeRestaurantsField() {
    final newState = state.copyWith(
      placeId: null,
      name: null,
      imageUrl: null,
      tags: {},
      rating: null,
      userRatingsTotal: null,
      latitude: null,
      longitude: null,
    );
    emit(newState);
  }

  Future<void> addRestaurant() async {
    final placeId = state.placeId;
    final name = state.name;
    final imageUrl = state.imageUrl;
    final tags = state.tags;
    final rating = state.rating;
    final userRatingsTotal = state.userRatingsTotal;
    final latitude = state.latitude;
    final longitude = state.longitude;

    final valid = name != null &&
        rating != null &&
        userRatingsTotal != null &&
        latitude != null &&
        longitude != null;

    final newState = state.copyWith(
      submissionStatus: valid ? SubmissionStatus.inProgress : null,
    );
    emit(newState);
    if (!valid) {
      final newState = state.copyWith(
        submissionStatus: SubmissionStatus.addRestaurantInvalidCredentials,
      );
      emit(newState);
    } else {
      try {
        final placeId$ = _uuid.v4();
        final message = await _restaurantsApi.addRestaurant(
          placeId ?? placeId$,
          name: name,
          rating: rating,
          imageUrl: imageUrl ?? '',
          tags: jsonEncode(tags.map((e) => e.name).toList()),
          userRatingsTotal: userRatingsTotal,
          latitude: latitude,
          longitude: longitude,
        );
        logger.i('Add restaurant message: $message');
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
          message: message,
        );
        emit(newState);
      } catch (e) {
        _errorFormatter(e);
      }
    }
  }

  Future<void> getRestaurants() async {
    final newState = state.copyWith(
      submissionStatus: SubmissionStatus.inProgress,
    );
    emit(newState);
    try {
      final restaurants = await _restaurantsApi.getRestaurants();
      final newState = state.copyWith(
        submissionStatus: SubmissionStatus.success,
        restaurants: restaurants,
      );
      emit(newState);
    } catch (e) {
      _errorFormatter(e);
    }
  }

  Future<void> updateRestaurant() async {
    final placeId = state.placeId;
    final name = state.name;
    final imageUrl = state.imageUrl;
    final tags = state.tags;
    final rating = state.rating;
    final userRatingsTotal = state.userRatingsTotal;
    final latitude = state.latitude;
    final longitude = state.longitude;

    final valid = placeId != null &&
        name != null &&
        rating != null &&
        userRatingsTotal != null &&
        latitude != null &&
        longitude != null;
    final newState = state.copyWith(
      submissionStatus: valid ? SubmissionStatus.inProgress : null,
    );
    emit(newState);
    if (!valid) {
      final newState = state.copyWith(
        submissionStatus: SubmissionStatus.updateRestaurantInvalidCredentials,
      );
      emit(newState);
    } else {
      try {
        final message = await _restaurantsApi.updateRestaurant(
          placeId,
          name: name,
          rating: rating,
          userRatingsTotal: userRatingsTotal,
          latitude: latitude,
          longitude: longitude,
          tags: jsonEncode(tags.map((e) => e.name).toList()),
          imageUrl: imageUrl,
        );
        final newState = state.copyWith(
          submissionStatus: SubmissionStatus.success,
          message: message,
        );
        emit(newState);
      } catch (e) {
        _errorFormatter(e);
      }
    }
  }

  Future<void> deleteRestaurant(String placeId) async {
    final newState = state.copyWith(
      submissionStatus: SubmissionStatus.inProgress,
    );
    emit(newState);
    try {
      final message = await _restaurantsApi.deleteRestaurant(placeId);
      final deleteInProggress = state.restaurants
          .map(
            (element) => element.placeId == placeId
                ? element.copyWith(isDeleting: true)
                : element,
          )
          .toList();
      final deletingState = state.copyWith(
        submissionStatus: SubmissionStatus.deleteInProggress,
        restaurants: deleteInProggress,
      );
      emit(deletingState);

      Future.delayed(const Duration(milliseconds: 1500), () {
        final deleteSuccess = state.copyWith(
          submissionStatus: SubmissionStatus.success,
          message: message,
          restaurants: [...state.restaurants]
            ..removeWhere((element) => element.placeId == placeId),
        );
        emit(deleteSuccess);
      });
    } catch (e) {
      _errorFormatter(e);
    }
  }

  void _errorFormatter(Object? e) {
    logger.e('Error type is: $e');
    if (e is NoRestaurantsFoundException) {
      logger.e('Message: ${e.message}');
      emit(
        state.copyWith(
          submissionStatus: SubmissionStatus.noRestaurants,
          message: e.message,
        ),
      );
    }
    if (e is AddRestaurantInvalidParametersException) {
      logger.e('Message: ${e.message}');
      emit(
        state.copyWith(
          submissionStatus: SubmissionStatus.addRestaurantInvalidCredentials,
          message: e.message,
        ),
      );
    }
    if (e is UpdateRestaurantInvalidParametersException) {
      logger.e('Message: ${e.message}');
      emit(
        state.copyWith(
          submissionStatus: SubmissionStatus.updateRestaurantInvalidCredentials,
          message: e.message,
        ),
      );
    }
    if (e is DeleteRestaurantInvalidParametersException) {
      logger.e('Message: ${e.message}');
      emit(
        state.copyWith(
          submissionStatus: SubmissionStatus.deleteRestaurantFailure,
          message: e.message,
        ),
      );
    }
    if (e is ClientRequestFailed) {
      logger.e('Message: ${e.message}');
      emit(
        state.copyWith(
          submissionStatus: SubmissionStatus.clientRequestFailed,
          message: e.message,
        ),
      );
    }
    if (e is MalformedClientResponse) {
      logger.e('Message: ${e.message}');
      emit(
        state.copyWith(
          submissionStatus: SubmissionStatus.malformedResponse,
          message: e.message,
        ),
      );
    }
  }
}
