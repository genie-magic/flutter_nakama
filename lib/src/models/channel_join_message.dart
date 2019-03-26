/// Send a channel join message to the server.
class ChannelJoinMessage {
  ChannelJoinMessage(this._target, this._type);

  final String _target;
  final int _type;
  bool _hidden;
  bool _persistence;
}
