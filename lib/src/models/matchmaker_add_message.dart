/// Add the user to the matchmaker pool with properties.
class MatchmakerAddMessage {
  int _MinCount;
  int _MaxCount;
  String _Query;
  Map<String, double> _NumericProperties;
  Map<String, String> _StringProperties;
}
