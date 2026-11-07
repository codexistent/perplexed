import 'dart:async';
import 'dart:convert';

import 'package:web_socket_client/web_socket_client.dart';

class ChatWebService {
  static final _instance = ChatWebService._internal();

  // set at build time: --dart-define=WS_URL=wss://fastapi/ws-chat
  static const _wsUrl = String.fromEnvironment(
    'WS_URL',
    defaultValue: 'ws://localhost:8000/ws/chat',
  );

  WebSocket? _socket;

  factory ChatWebService() => _instance;

  ChatWebService._internal();
  final _searchResultController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _contentController = StreamController<Map<String, dynamic>>.broadcast();
  final _statusController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get searchResultStream =>
      _searchResultController.stream;
  Stream<Map<String, dynamic>> get contentStream => _contentController.stream;
  Stream<Map<String, dynamic>> get statusStream => _statusController.stream;

  // connect client to websocket
  void connect() {
    if (_socket != null) return;
    _socket = WebSocket(Uri.parse(_wsUrl));

    _socket!.messages.listen((message) {
      final data = json.decode(message);
      if (data['type'] == 'search_result') {
        _searchResultController.add(data);
      } else if (data['type'] == 'content') {
        _contentController.add(data);
      } else if (data['type'] == 'done' || data['type'] == 'error') {
        _statusController.add(data);
      }
    });
  }

  void chat(String query) {
    connect();
    _socket!.send(json.encode({'query': query}));
  }
}
