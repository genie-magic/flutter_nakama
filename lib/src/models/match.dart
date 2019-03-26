import 'user_presence.dart';

/// A multiplayer match.
class Match {
  /// True if this match has an authoritative handler on the server.
  bool _authoritative;

  /// The unique match identifier.
  String _matchId;

  /// A label for the match which can be filtered on.
  String _label;

  /// The presences already in the match.
  List<UserPresence> _presences;

  /// The number of users currently in the match.
  int _size;

  /// The current user in this match. i.e. Yourself.
  UserPresence self;
}
