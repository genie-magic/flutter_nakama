import 'dart:typed_data';
import 'package:flutter_nakama/src/models/status.dart';
import 'package:grpc/grpc.dart';

import 'package:flutter_nakama/src/models/channel.dart';
import 'package:flutter_nakama/src/models/channel_message_ack.dart';
import 'package:flutter_nakama/src/models/channel_type.dart';
import 'package:flutter_nakama/src/models/matchmaker_ticket.dart';
import 'package:flutter_nakama/src/models/socket_listener.dart';
import 'package:flutter_nakama/src/models/user_presence.dart';

import 'session.dart';

abstract class SocketClient {
/// Connect to the server.
/// @param session The session of the user.
/// @param listener An event listener to notify on updates.
/// @return A future.
Future<Session> connect(Session session, SocketListener listener);

/// Connect to the server.
/// @param session The session of the user.
/// @param listener An event listener to notify on updates.
/// @param createStatus True if the socket should show the user as online to others.
/// @return A future.
Future<Session> connectWithStatus(Session session, SocketListener listener, bool createStatus);

/// Close the connection with the server.
/// @return A close future.
Future<bool> disconnect();

/// Join a chat channel on the server.
/// @param target The target channel to join.
/// @param type The type of channel to join.
/// @return A future which resolves to a Channel response.
Future<Channel> joinChat(final String target, final ChannelType type);

/// Join a chat channel on the server.
/// @param target The target channel to join.
/// @param type The type of channel to join.
/// @param persistence True if chat messages should be stored.
/// @return A future which resolves to a Channel response.
Future<Channel> joinChatWithPersistence(final String target, final ChannelType type, bool persistence);

/// Join a chat channel on the server.
/// @param target The target channel to join.
/// @param type The type of channel to join.
/// @param persistence True if chat messages should be stored.
/// @param hidden True if the user should be hidden on the channel.
/// @return A future which resolves to a Channel response.
Future<Channel> joinChatWithPersistenceAndHidden(final String target, final ChannelType type, bool persistence, bool hidden);

/// Leave a chat channel on the server.
/// @param channelId The channel to leave.
/// @return A future.
Future<void> leaveChat(final String channelId);

/// Remove a chat message from a channel on the server.
/// @param channelId The chat channel with the message.
/// @param messageId The ID of a chat message to update.
/// @return A future.
Future<ChannelMessageAck> removeChatMessage(final String channelId, final String messageId);

/// Send a chat message to a channel on the server.
/// @param channelId The channel to send on.
/// @param content The content of the chat message.
/// @return A future which resolves to a Channel Ack response.
Future<ChannelMessageAck> writeChatMessage(final String channelId, final String content);

/// Update a chat message to a channel on the server.
/// @param channelId The ID of the chat channel with the message.
/// @param messageId The ID of the message to update.
/// @param content The content update for the message.
/// @return A future.
Future<ChannelMessageAck> updateChatMessage(final String channelId, final String messageId, final String content);

/// Create a multiplayer match on the server.
/// @return A future.
Future<Match> createMatch();

/// Join a multiplayer match by ID.
/// @param matchId A match ID.
/// @return A future which resolves to the match joined.
Future<Match> joinMatch(final String matchId);

/// Join a multiplayer match with a matchmaker.
/// @param token A matchmaker ticket result object.
/// @return A future which resolves to the match joined.
Future<Match> joinMatchToken(final String token);

/// Leave a match on the server.
/// @param matchId The match to leave.
/// @return A future.
Future<void> leaveMatch(final String matchId);

/// Join the matchmaker pool and search for opponents on the server.
/// @param query A matchmaker query to search for opponents.
/// @param minCount The minimum number of players to compete against.
/// @param maxCount The maximum number of players to compete against.
/// @param stringProperties A set of k/v properties to provide in searches.
/// @param numericProperties A set of k/v numeric properties to provide in searches.
/// @return A future which resolves to a matchmaker ticket object.
Future<MatchmakerTicket> addMatchmaker(final int minCount, final int maxCount, final String query, final Map<String, String> stringProperties, final Map<String, double> numericProperties);

/// Leave the matchmaker pool by ticket.
/// @param ticket The ticket returned by the matchmaker on join. See <c>IMatchmakerTicket.Ticket</c>.
/// @return A future.
Future<void> removeMatchmaker(final String ticket);

/// Send a state change to a match on the server.
/// When no presences are supplied the new match state will be sent to all presences.
/// @param matchId The Id of the match.
/// @param opCode An operation code for the match state.
/// @param data The new state to send to the match.
/// @param presences The presences in the match to send the state.
void sendMatchData(final String matchId, final int opCode, Uint8List data, List<UserPresence> presences);

/// Send an RPC message to the server.
/// @param id The ID of the function to execute.
/// @return A future which resolves to an RPC response.
Future<GrpcMessage> rpc(final String id);

/// Send an RPC message to the server.
/// @param id The ID of the function to execute.
/// @param payload The string content to send to the server.
/// @return A future which resolves to an RPC response.
Future<GrpcMessage> rpcWithString(final String id, final String payload);

/// Follow one or more users for status updates.
/// @param userIds The user Ids to follow.
/// @return A future.
Future<Status> followUsers(final List<String> userIds);

/// Unfollow status updates for one or more users.
/// @param userIds The ids of users to unfollow.
/// @return A future.
Future<void> unfollowUsers(final List<String> userIds);

/// Update the user's status online.
/// @param status The new status of the user.
/// @return A future.
Future<void> updateStatus(final String status);
}
