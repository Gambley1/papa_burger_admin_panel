part of 'navigation_rail_cubit.dart';

class NavigationRailState {
  const NavigationRailState._({
    this.currentIndex = 0,
  });

  const NavigationRailState.initial() : this._();

  final int currentIndex;

  NavigationRailState copyWith({
    int? currentIndex,
  }) {
    return NavigationRailState._(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
