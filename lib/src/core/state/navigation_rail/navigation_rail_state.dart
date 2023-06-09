part of 'navigation_rail_cubit.dart';

class NavigationRailState {
  NavigationRailState({required this.currentIndex});

  factory NavigationRailState.initial() => NavigationRailState(currentIndex: 0);

  final int currentIndex;

  NavigationRailState copyWith({
    int? currentIndex,
  }) {
    return NavigationRailState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
