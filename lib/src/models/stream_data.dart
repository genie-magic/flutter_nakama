import 'user_presence.dart';

/// A state change received from a stream.
class StreamData {
  /// The user who sent the state change. May be <c>null</c>.
  UserPresence _sender;

  /// The contents of the state change.
  String _data;

  /// The identifier for the stream.
  Stream _stream;
}