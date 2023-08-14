import 'package:bloc/bloc.dart';
import 'package:papa_burger_admin_panel/src/config/utils/logger.dart';

part 'navigation_rail_state.dart';

class NavigationRailCubit extends Cubit<NavigationRailState> {
  NavigationRailCubit() : super(const NavigationRailState.initial());

  void onNavigation(int value) {
    if (state.currentIndex == value) return;
    logger.i('$value index selected');
    final newState = state.copyWith(currentIndex: value);
    emit(newState);
  }
}
