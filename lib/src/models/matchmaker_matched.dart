import 'matchmaker_user.dart';

/// The result of a successful matchmaker operation sent to the server.
class MatchmakerMatched {
  /// The id used to join the match.
  /// A match ID used to join the match.
  String _matchId;

  /// The ticket sent by the server when the user requested to matchmake for other players.
  String _ticket;

  /// The token used to join a match.
  String _token;

  /// The other users matched with this user and the parameters they sent.
  List<MatchmakerUser> _users;

  /// The current user who matched with opponents.
  MatchmakerUser _self;
}
