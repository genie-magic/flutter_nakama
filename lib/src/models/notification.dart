/// A notification object.
// This message type is only used for GSON, and not exposed to the Client interface.
class Notification {
  String _id;
  String _subject;
  String _content;
  int _code;
  String _senderId;
  DateTime _createTime;
  bool _persistent;
}
