import 'notification.dart';

/// List of notifications with cursor.
// This message type is only used for GSON, and not exposed to the Client interface.
class NotificationList {
  List<Notification> _notifications;
  String _cacheableCursor;
}
