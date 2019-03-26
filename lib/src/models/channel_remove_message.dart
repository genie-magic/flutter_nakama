/// A remove message for a chat channel.
class ChannelRemoveMessage {
  ChannelRemoveMessage(this._channelId, this._messageId);

  final String _channelId;
  final String _messageId;
}
