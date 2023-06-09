import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_actions_state.dart';

class MenuActionsCubit extends Cubit<MenuActionsState> {
  MenuActionsCubit() : super(MenuActionsInitial());
}
