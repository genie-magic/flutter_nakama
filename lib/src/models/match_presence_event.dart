import 'user_presence.dart';

/// A batch of join and leave presences for a match.
class MatchPresenceEvent {
  /// The unique match identifier.
  String _matchId;

  /// Presences of users who joined the match.
  List<UserPresence> _joins;

  /// Presences of users who left the match.
  List<UserPresence> _leaves;
}
