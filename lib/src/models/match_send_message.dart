import 'user_presence.dart';
import 'dart:typed_data';

/// Send new state to a match on the server.
class MatchSendMessage {
  String _matchId;
  int _opCode;
  Uint8List data;
  List<UserPresence> _presences;
}
