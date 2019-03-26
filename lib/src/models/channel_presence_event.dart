import 'user_presence.dart';

/// A batch of join and leave presences on a chat channel.
class ChannelPresenceEvent {
  /// The unique identifier of the chat channel.
  String _channelId;

  /// The unique identifier of the chat channel.
  List<UserPresence> _joins;

  /// Presences of users who left the channel.
  List<UserPresence> _leaves;
}
