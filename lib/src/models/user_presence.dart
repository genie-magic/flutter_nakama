/// An object which represents a connected user in the server.
/// The server allows the same user to be connected with multiple sessions. To uniquely identify them a tuple of
/// <c>{ user_id, session_id }</c> is used which is exposed as this object.
class UserPresence {
  /// True if this presence generates stored events like persistent chat messages or notifications.
  bool _persistence;

  /// The session id of the user.
  String _sessionId;

  /// The status of the user with the presence on the server.
  String _status;

  /// The username for the user.
  String _username;

  /// The id of the user.
  String _userId;
}
