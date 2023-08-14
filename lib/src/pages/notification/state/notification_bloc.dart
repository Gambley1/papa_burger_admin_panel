import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/connection_state_to_status.dart';
import 'package:papa_burger_admin_panel/src/core/repository/notification_repository.dart';
import 'package:papa_burger_admin_panel/src/pages/counter/state/counter_bloc.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({NotificationRepository? notificationRepository})
      : _notificationRepository =
            notificationRepository ?? NotificationRepository(),
        super(const NotificationState.initial()) {
    on<NotificationStarted>(_onNotificationStarted);
    on<_NotificationMessageChanged>(_onNotificationMessageChanged);
    on<_NotificationConnectionStatusChanged>(
      _onNotificationConnectionStatusChanged,
    );
  }

  final NotificationRepository _notificationRepository;
  StreamSubscription<String>? _messagesSubscription;
  StreamSubscription<ConnectionState>? _connectionStateSubscrption;

  void _onNotificationStarted(
    NotificationStarted event,
    Emitter<NotificationState> emit,
  ) {
    _messagesSubscription =
        _notificationRepository.notifications().listen((message) {
      add(_NotificationMessageChanged(message));
    });

    _connectionStateSubscrption =
        _notificationRepository.connection().listen((status) {
      add(_NotificationConnectionStatusChanged(status));
    });
  }

  void _onNotificationMessageChanged(
    _NotificationMessageChanged event,
    Emitter<NotificationState> emit,
  ) {
    emit(
      state.copyWith(
        message: event.message,
        status: ConnectionStatus.connected,
      ),
    );
  }

  void _onNotificationConnectionStatusChanged(
    _NotificationConnectionStatusChanged event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(status: event.state.toStatus()));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _connectionStateSubscrption?.cancel();
    return super.close();
  }
}
