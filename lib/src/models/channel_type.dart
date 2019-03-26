class ChannelType {
  final int _value;

  const ChannelType._internal(this._value);

  @override
  String toString() {
    return 'Enum.$_value';
  }

  /// A chat room which can be created dynamically with a name.
  static const ROOM = const ChannelType._internal(0);

  /// A private chat between two users.
  static const DIRECT_MESSAGE = const ChannelType._internal(1);

  /// A chat within a group on the server.
  static const GROUP = const ChannelType._internal(2);
}
