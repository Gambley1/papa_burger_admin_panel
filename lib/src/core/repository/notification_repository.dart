import 'package:web_socket_client/web_socket_client.dart';

class NotificationRepository {
  NotificationRepository({WebSocket? socket})
      : _ws = socket ??
            WebSocket(
              Uri.parse(
                'ws://papa-burger-server-production.up.railway.app/ws/notification',
              ),
            );

  final WebSocket _ws;

  Stream<String> notifications() => _ws.messages.cast<String>();

  Stream<ConnectionState> connection() => _ws.connection;

  void close() => _ws.close();
}
