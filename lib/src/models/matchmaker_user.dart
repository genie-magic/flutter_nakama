import 'user_presence.dart';

/// The user with the parameters they sent to the server when asking for opponents.
class MatchmakerUser {
  /// The numeric properties which this user asked to matchmake with.
  Map<String, double> _numericProperties;

  /// The presence of the user.
  UserPresence _presence;

  /// The string properties which this user asked to matchmake with.
  Map<String, String> _stringProperties;
}
