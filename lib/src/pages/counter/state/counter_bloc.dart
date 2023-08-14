import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/connection_state_to_status.dart';
import 'package:papa_burger_admin_panel/src/core/repository/counter_repository.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({CounterRepository? counterRepository})
      : _counterRepository = counterRepository ?? CounterRepository(),
        super(const CounterState.initial()) {
    on<CounterStarted>(_onCounterStarted);
    on<CounterIncrementPressed>(_onCounterIncrementPressed);
    on<CounterDecrementPressed>(_onCounterDecrementPressed);
    on<_CounterCountChanged>(_onCounterCountChanged);
    on<_CounterConnectionStateChanged>(_onCounterConnectionStateChanged);
  }

  final CounterRepository _counterRepository;
  StreamSubscription<int>? _countSubscription;
  StreamSubscription<ConnectionState>? _connectionStateSubscription;

  void _onCounterStarted(
    CounterStarted event,
    Emitter<CounterState> emit,
  ) {
    _countSubscription = _counterRepository.count().listen((count) {
      add(_CounterCountChanged(count));
    });

    _connectionStateSubscription =
        _counterRepository.connection().listen((state) {
      add(_CounterConnectionStateChanged(state));
    });
  }

  void _onCounterIncrementPressed(
    CounterIncrementPressed event,
    Emitter<CounterState> emit,
  ) {
    _counterRepository.increment();
  }

  void _onCounterDecrementPressed(
    CounterDecrementPressed event,
    Emitter<CounterState> emit,
  ) {
    _counterRepository.decrement();
  }

  void _onCounterConnectionStateChanged(
    _CounterConnectionStateChanged event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(status: event.state.toStatus()));
  }

  void _onCounterCountChanged(
    _CounterCountChanged event,
    Emitter<CounterState> emit,
  ) {
    emit(
      state.copyWith(count: event.count, status: ConnectionStatus.connected),
    );
  }

  @override
  Future<void> close() {
    _countSubscription?.cancel();
    _connectionStateSubscription?.cancel();
    return super.close();
  }
}
