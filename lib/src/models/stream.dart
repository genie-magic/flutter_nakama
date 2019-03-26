/// A realtime socket stream on the server.
class Stream {

  /// The descriptor of the stream. Used with direct chat messages and contains a second user id.
  String _descriptor;

  /// Identifies streams which have a context across users like a chat channel room.
  String _label;

  /// The mode of the stream.
  int _mode;

  /// The subject of the stream. This is usually a user id.
  String _subject;
}
