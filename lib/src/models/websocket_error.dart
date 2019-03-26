/// An error that occurred in the websocket transport.
// This message type is only used for GSON, and not exposed to the Client interface.
class WebSocketError {
  int _code;
  String _message;
  Map<String, String> _context;

  String get message {
    return this._message;
  }

  set message (String message){
    this._message = message;
  }

  int get code {
    return this._code;
  }

  set code (int code) {
    this._code = code;
  }
}
