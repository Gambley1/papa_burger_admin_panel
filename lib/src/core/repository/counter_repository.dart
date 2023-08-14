import 'package:web_socket_client/web_socket_client.dart';

class CounterRepository {
  CounterRepository({WebSocket? socket})
      : _ws = socket ??
            WebSocket(Uri.parse('ws://192.168.1.166:8080/ws/counter'));

  final WebSocket _ws;

  void increment() => _ws.send('__increment__');

  void decrement() => _ws.send('__decrement__');

  Stream<int> count() => _ws.messages.cast<String>().map(int.parse);

  Stream<ConnectionState> connection() => _ws.connection;

  void close() => _ws.close();
}
