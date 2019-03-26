import 'dart:convert';
import 'user_presence.dart';
import 'dart:typed_data';

/// Some game state update in a match.
class MatchData {
  /// The unique match identifier.
  String _matchId;

  /// The operation code for the state change.
  /// This value can be used to mark the type of the contents of the state.
  int _opCode;

  /// the base-64 contents of the state change.
  String _data;

  /// Information on the user who sent the state change.
  UserPresence _userPresence;

  /// Returns match data
  /// @return match data
  Uint8List getData() {
    if (this._data == null) {
      return null;
    }
    return base64.decode(this._data);
  }
}
