/// A session used with requests sent to Nakama server.
abstract class Session {
  /// @return <c>True</c> if the user account for this session was just created.
  bool isCreated();

  /// @return <c>True</c> if the session has expired against the current time.
  bool IsExpired();

  /// Check if the session has expired against the input time.
  /// @param dateTime The time to compare against the session.
  /// @return <c>true</c> if the session has expired.
  bool isExpired(DateTime dateTime);
}
