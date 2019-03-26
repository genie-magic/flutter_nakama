
class ErrorCode {
  final int _value;

  const ErrorCode._internal(this._value);

  @override
  String toString() {
    return 'ErrorCode.$_value';
  }

  static const UNKNOWN = const ErrorCode._internal(0);
  static const RUNTIME_EXCEPTION = const ErrorCode._internal(1);
  static const UNRECOGNISED_PAYLOAD = const ErrorCode._internal(2);
  static const MISSING_PAYLOAD = const ErrorCode._internal(3);
  static const BAD_INPUT = const ErrorCode._internal(4);
  static const MATCH_NOT_FOUND = const ErrorCode._internal(5);
  static const MATCH_JOIN_REJECTED = const ErrorCode._internal(6);
  static const RUNTIME_FUNCTION_NOT_FOUND = const ErrorCode._internal(7);
  static const RUNTIME_FUNCTION_EXCEPTION = const ErrorCode._internal(8);

  static ErrorCode fromInt(final int code) {
    switch (code) {
      case 0:
        return RUNTIME_EXCEPTION;
      case 1:
        return UNRECOGNISED_PAYLOAD;
      case 2:
        return MISSING_PAYLOAD;
      case 3:
        return BAD_INPUT;
      case 4:
        return MATCH_NOT_FOUND;
      case 5:
        return MATCH_JOIN_REJECTED;
      case 6:
        return RUNTIME_FUNCTION_NOT_FOUND;
      case 7:
        return RUNTIME_FUNCTION_EXCEPTION;
      default:
        return UNKNOWN;
    }
  }
}

abstract class Error implements Exception {
  String _message;

  Error(String message) {
    this._message = message;
  }

  /// @return The code for the error.
  ErrorCode getCode();

  /// @return The collation ID associated with this error. Could be null.
  String getCollationId();
}