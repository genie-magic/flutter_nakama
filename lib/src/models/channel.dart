import 'user_presence.dart';

class Channel {
  /// The server-assigned channel ID.
  String _id;

  /// The presences visible on the chat channel.
  List<UserPresence> _presences;

  /// The presence of the current user. i.e. Your self.
  UserPresence _self;
}
