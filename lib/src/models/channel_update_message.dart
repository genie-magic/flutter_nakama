/// Update a chat message which has been sent to a channel.
class ChannelUpdateMessage {
  ChannelUpdateMessage(this._channelId, this._messageId, this._content);

  final String _channelId;
  final String _messageId;
  final String _content;
}
