// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_bloc.dart';

enum ConnectionStatus { connected, disconnected }

class CounterState extends Equatable {
  const CounterState._({
    this.status = ConnectionStatus.disconnected,
    this.count = 0,
  });

  const CounterState.initial() : this._();

  final int count;
  final ConnectionStatus status;

  @override
  List<Object> get props => [status, count];

  CounterState copyWith({
    int? count,
    ConnectionStatus? status,
  }) {
    return CounterState._(
      count: count ?? this.count,
      status: status ?? this.status,
    );
  }
}
