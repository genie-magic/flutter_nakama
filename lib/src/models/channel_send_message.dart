/// Send a chat message to a channel on the server.
class ChannelSendMessage {
  ChannelSendMessage(this._channelId, this._content);

  final String _channelId;
  final String _content;
}
