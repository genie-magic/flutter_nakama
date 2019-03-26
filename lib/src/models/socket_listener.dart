import 'channel_message.dart';
import 'channel_presence_event.dart';
import 'matchmaker_matched.dart';
import 'match_data.dart';
import 'match_presence_event.dart';
import 'notification_list.dart';
import 'status_presence_event.dart';
import 'stream_presence_event.dart';
import 'stream_data.dart';

/// A listener for receiving {@code Client} events.
abstract class SocketListener {
/// Called when the client socket disconnects.
/// Throwable t is set if an error caused the disconnect.
Future onDisconnect(final Exception t);

/// Called when the client receives an error.
/// @param error The {@code Error} received.
void onError(final Error error);

/// Called when a new topic message has been received.
/// @param message The {@code ChannelMessage} received.
void onChannelMessage(final ChannelMessage message);

/// Called when a new topic presence update has been received.
/// @param presence The {@code ChannelPresenceEvent} received.
void onChannelPresence(final ChannelPresenceEvent presence);

/// Called when a matchmaking has found a match.
/// @param matched The {@code MatchmakerMatched} received.
void onMatchmakerMatched(final MatchmakerMatched matched);

/// Called when a new match data is received.
/// @param matchData The {@code MatchData} received.
void onMatchData(final MatchData matchData);

/// Called when a new match presence update is received.
/// @param matchPresence The {@code MatchPresenceEvent} received.
void onMatchPresence(final MatchPresenceEvent matchPresence);

/// Called when the client receives new notifications.
/// @param notifications The list of {@code Notification} received.
void onNotifications(final NotificationList notifications);

/// Called when the client receives status presence updates.
/// @param presence Updated {@code StatusPresenceEvent} presence.
void onStatusPresence(final StatusPresenceEvent presence);

/// Called when the client receives stream presence updates.
/// @param presence Updated {@code StreamPresenceEvent} presence.
void onStreamPresence(final StreamPresenceEvent presence);

/// Called when the client receives stream data.
/// @param data Stream {@code StreamData} data received.
void onStreamData(final StreamData data);
}
