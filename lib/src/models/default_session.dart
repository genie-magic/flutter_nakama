import 'session.dart';
import 'dart:convert';

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

class DefaultSession extends Session {
  int _createTime;
  int _expireTime;
  bool _created;
  String _username;
  String _userId;
  String _authToken;

  DefaultSession(String token, bool created) {
    final List<String> decoded = token.split("\\.");
    if (decoded.length != 3) {
      throw new ArgumentError("Not a valid token.");
    }

    final String decodedJson = _decodeBase64(decoded[1]);
    Map<String, Object> jsonMap = jsonDecode(decodedJson);

    this._createTime = DateTime
        .now()
        .millisecondsSinceEpoch;
    // this._expireTime = Math.round(((Double) jsonMap.get("exp")) * 1000L);
    this._expireTime = (double.parse(jsonMap['exp']) * 1000).round();
    this._username = jsonMap["usn"].toString();
    this._userId = jsonMap["uid"].toString();
    this._created = created;
    this._authToken = token;
  }

  @override
  bool IsExpired() {
    return isExpired(DateTime.now());
  }

  @override
  bool isExpired(DateTime dateTime) {
    return (_expireTime - dateTime.millisecondsSinceEpoch) < 0;
  }

  @override
  bool isCreated() {
    return this._created;
  }

  // Getters and setters
  get authToken {
    return this._authToken;
  }

  get createTime {
    return this._createTime;
  }

  get expireTime {
    return this._expireTime;
  }

  get username {
    return this._username;
  }

  get userId {
    return this._userId;
  }
}