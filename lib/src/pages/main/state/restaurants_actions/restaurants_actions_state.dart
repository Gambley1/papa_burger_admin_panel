// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'restaurants_actions_cubit.dart';

enum SubmissionStatus {
  idle,
  success,
  inProgress,
  deleteInProggress,
  noRestaurants,
  clientRequestFailed,
  malformedResponse,
  addRestaurantInvalidCredentials,
  updateRestaurantInvalidCredentials,
  deleteRestaurantFailure,
}

class RestaurantsActionsState extends Equatable {
  const RestaurantsActionsState._({
    this.restaurants = const [],
    this.submissionStatus = SubmissionStatus.idle,
    this.name,
    this.tags = const {},
    this.imageUrl,
    this.rating,
    this.userRatingsTotal,
    this.latitude,
    this.longitude,
    this.placeId,
    this.message,
  });

  const RestaurantsActionsState.initial() : this._();

  bool get loading => submissionStatus == SubmissionStatus.inProgress;
  bool get deleting => submissionStatus == SubmissionStatus.deleteInProggress;
  bool get success => submissionStatus == SubmissionStatus.success;
  bool get noRestaurants => submissionStatus == SubmissionStatus.noRestaurants;
  bool get clientRequestFailed =>
      submissionStatus == SubmissionStatus.clientRequestFailed;
  bool get malformedResponse =>
      submissionStatus == SubmissionStatus.malformedResponse;
  bool get addRestaurantInvalidCredentials =>
      submissionStatus == SubmissionStatus.addRestaurantInvalidCredentials;
  bool get updateRestaurantInvalidCredentials =>
      submissionStatus == SubmissionStatus.updateRestaurantInvalidCredentials;
  bool get deleteRestaurantFailure =>
      submissionStatus == SubmissionStatus.deleteRestaurantFailure;

  final List<Restaurant> restaurants;
  final String? placeId;
  final String? name;
  final Set<Tag> tags;
  final String? imageUrl;
  final double? rating;
  final int? userRatingsTotal;
  final double? latitude;
  final double? longitude;
  final SubmissionStatus submissionStatus;
  final String? message;

  RestaurantsActionsState copyWith({
    List<Restaurant>? restaurants,
    String? placeId,
    String? name,
    Set<Tag>? tags,
    String? imageUrl,
    double? rating,
    int? userRatingsTotal,
    double? latitude,
    double? longitude,
    SubmissionStatus? submissionStatus,
    String? message,
  }) {
    return RestaurantsActionsState._(
      restaurants: restaurants ?? this.restaurants,
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        restaurants,
        submissionStatus,
        placeId,
        name,
        tags,
        imageUrl,
        rating,
        userRatingsTotal,
        latitude,
        longitude,
        message,
      ];
}
