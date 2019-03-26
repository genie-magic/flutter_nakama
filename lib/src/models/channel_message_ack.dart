/// An acknowledgement from the server when a chat message is delivered to a channel.
class ChannelMessageAck {
  /// A unique ID for the chat message.
  String _messageId;

  /// The server-assigned channel ID.
  String _channelId;

  /// A user-defined code for the chat message.
  int _code;

  /// The username of the sender of the message.
  String _username;

  /// True if the chat message has been stored in history.
  bool _persistent;

  /// The UNIX time when the message was created.
  DateTime _createTime;

  /// The UNIX time when the message was updated.
  DateTime _updateTime;
}
