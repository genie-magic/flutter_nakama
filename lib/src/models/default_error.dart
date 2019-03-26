import 'error.dart';
import 'websocket_error.dart';

class DefaultError extends Error {
  ErrorCode _code = ErrorCode.UNKNOWN;
  String _collationId = null;
  String _message;

  DefaultError(String message) {
    this._message = message;

    this._code = ErrorCode.UNKNOWN;
    this._collationId = null;
  }

  DefaultErrorWithCode(String collationId, WebSocketError error) {
    this._message = error.message;
    this._code = ErrorCode.fromInt(error.code);
    this._collationId = collationId;
  }
}