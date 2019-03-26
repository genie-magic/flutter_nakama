// A message sent on a channel.
// This message type is only used for GSON, and not exposed to the Client interface.
class ChannelMessage {
  String _channelId;
  String _messageId;
  int _code;
  String _senderId;
  String _username;
  String _content;
  DateTime _createTime;
  DateTime _updateTime;
  bool _persistent;
}
