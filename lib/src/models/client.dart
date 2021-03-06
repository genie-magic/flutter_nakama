import 'package:flutter_nakama/src/models/session.dart';
import 'package:flutter_nakama/src/models/socket_client.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart';

abstract class Client {
  /// Disconnects the client. This function kills all outgoing exchanges and waits until the channel is shutdown.
  void disconnectAndWait(final int timeout, final Duration unit);

  /// Disconnects the client. This function kills all outgoing exchanges immediately without waiting.
  void disconnect();

  /// Create a new socket from the client.
  /// @param port The port number of the server. Default should be 7350.
  /// @param socketTimeoutMs Sets the connect, read and write timeout for new connections.
  /// @return a new SocketClient instance.
  SocketClient createSocket(final int port, final int socketTimeoutMs);

  /// Add one or more friends by id or username.
  /// @param session The session of the user.
  /// @param ids The ids of the users to add or invite as friends.
  /// @param usernames The usernames of the users to add as friends.
  /// @return A future.
  Future<void> addFriends(final Session session, final Iterable<String> ids, final List<String> usernames);

  /// Add one or more users to the group.
  /// @param session The session of the user.
  /// @param groupId The id of the group to add users into.
  /// @param ids The ids of the users to add or invite to the group.
  /// @return A future.
  Future<void> addGroupUsers(final Session session, final String groupId, final List<String> ids);

  /// Authenticate a user with a custom id.
  /// @param id A custom identifier usually obtained from an external authentication service.
  /// @param create True if the user should be created when authenticated.
  /// @param username A username used to create the user.
  /// @return A future to resolve a session object.
  Future<Session> authenticateCustom(final String id, final bool create, final String username);

  /// Authenticate a user with a device id.
  /// @param id A device identifier usually obtained from a platform API.
  /// @param create True if the user should be created when authenticated.
  /// @param username A username used to create the user.
  /// @return A future to resolve a session object.
  Future<Session> authenticateDevice(final String id, final bool create, final String username);

  /// Authenticate a user with an email and password.
  /// @param email The email address of the user.
  /// @param password The password for the user.
  /// @param create True if the user should be created when authenticated.
  /// @param username A username used to create the user.
  /// @return A future to resolve a session object.
  Future<Session> authenticateEmail(final String email, final String password, final bool create, final String username);

  /// Authenticate a user with a Facebook auth token.
  /// @param accessToken An OAuth access token from the Facebook SDK.
  /// @param create True if the user should be created when authenticated.
  /// @param username A username used to create the user.
  /// @param importFriends True if the Facebook friends should be imported.
  /// @return A future to resolve a session object.
  Future<Session> authenticateFacebook(final String accessToken, final bool create, final String username, final bool importFriends);

  /// Authenticate a user with a Google auth token.
  /// @param accessToken An OAuth access token from the Google SDK.
  /// @param create True if the user should be created when authenticated.
  /// @param username A username used to create the user.
  /// @return A future to resolve a session object.
  Future<Session> authenticateGoogle(final String accessToken, final bool create, final String username);

  /// Authenticate a user with a Steam auth token.
  /// @param token An authentication token from the Steam network.
  /// @param create True if the user should be created when authenticated.
  /// @param username A username used to create the user.
  /// @return A future to resolve a session object.
  Future<Session> authenticateSteam(final String token, final bool create, final String username);

  /// Authenticate a user with Apple Game Center.
  /// @param playerId The player id of the user in Game Center.
  /// @param bundleId The bundle id of the Game Center application.
  /// @param timestampSeconds The date and time that the signature was created.
  /// @param salt A random <c>NSString</c> used to compute the hash and keep it randomized.
  /// @param signature The verification signature data generated.
  /// @param publicKeyUrl The URL for the public encryption key.
  /// @param create True if the user should be created when authenticated.
  /// @param username A username used to create the user.
  /// @return A future to resolve a session object.
  Future<Session> authenticateGameCenter(final String playerId, final String bundleId, final int timestampSeconds, final String salt, final String signature, final String publicKeyUrl, final bool create, final String username);

  /// Block one or more friends by id or username.
  /// @param session The session of the user.
  /// @param ids The ids of the users to block.
  /// @param usernames The usernames of the users to block.
  /// @return A future.
  Future<void> blockFriends(final Session session, final Iterable<String> ids, final List<String> usernames);

  /// Create a group.
  /// @param session The session of the user.
  /// @param name The name for the group.
  /// @param description A description for the group.
  /// @param avatarUrl An avatar url for the group.
  /// @param langTag A language tag in BCP-47 format for the group.
  /// @param open True if the group should have open membership.
  /// @return A future to resolve a new group object.
  Future<Group> createGroup(final Session session, final String name, final String description, final String avatarUrl, final String langTag, final bool open);

  /**
   * Delete one more or users by id.
   * @param session The session of the user.
   * @param ids the user ids to remove as friends.
   * @return A future.
   */
  ListenableFuture<Empty> deleteFriends(@NonNull final Session session, @NonNull final String... ids);

  /**
   * Delete one more or users by id or username from friends.
   * @param session The session of the user.
   * @param ids the user ids to remove as friends.
   * @param usernames The usernames to remove as friends.
   * @return A future.
   */
  ListenableFuture<Empty> deleteFriends(@NonNull final Session session, final Iterable<String> ids, final String... usernames);

  /**
   * Delete a group by id.
   *
   * @param session The session of the user.
   * @param groupId The group id to to remove.
   * @return A future.
   */
  ListenableFuture<Empty> deleteGroup(@NonNull final Session session, @NonNull final String groupId);

  /**
   * Delete a leaderboard record.
   *
   * @param session The session of the user.
   * @param leaderboardId The id of the leaderboard with the record to be deleted.
   * @return A future.
   */
  ListenableFuture<Empty> deleteLeaderboardRecord(@NonNull final Session session, @NonNull final String leaderboardId);

  /**
   * Delete one or more notifications by id.
   *
   * @param session The session of the user.
   * @param notificationIds The notification ids to remove.
   * @return A future.
   */
  ListenableFuture<Empty> deleteNotifications(@NonNull final Session session, @NonNull final String... notificationIds);

  /**
   * Delete one or more storage objects.
   *
   * @param session The session of the user.
   * @param objectIds The ids of the objects to delete.
   * @return A future.
   */
  ListenableFuture<Empty> deleteStorageObjects(@NonNull final Session session, @NonNull final StorageObjectId... objectIds);

  /**
   * Fetch the user account owned by the session.
   *
   * @param session The session of the user.
   * @return A future to resolve an account object.
   */
  ListenableFuture<Account> getAccount(@NonNull final Session session);

  /**
   * Fetch one or more users by id, usernames, and Facebook ids.
   *
   * @param session The session of the user.
   * @param ids List of user IDs.
   * @return A future to resolve user objects.
   */
  ListenableFuture<Users> getUsers(@NonNull final Session session, @NonNull final String... ids);

  /**
   * Fetch one or more users by id, usernames, and Facebook ids.
   *
   * @param session The session of the user.
   * @param ids List of user IDs.
   * @param usernames List of usernames.
   * @return A future to resolve user objects.
   */
  ListenableFuture<Users> getUsers(@NonNull final Session session, final Iterable<String> ids, final String... usernames);

  /**
   * Fetch one or more users by id, usernames, and Facebook ids.
   *
   * @param session The session of the user.
   * @param ids List of user IDs.
   * @param usernames List of usernames.
   * @param facebookIds List of Facebook IDs.
   * @return A future to resolve user objects.
   */
  ListenableFuture<Users> getUsers(@NonNull final Session session, final Iterable<String> ids, final Iterable<String> usernames, final String... facebookIds);

  /**
   * Import Facebook friends and add them to the user's account.
   *
   * The server will import friends when the user authenticates with Facebook. This function can be used to be
   * explicit with the import operation.
   *
   * @param session The session of the user.
   * @param token An OAuth access token from the Facebook SDK.
   * @return A future.
   */
  ListenableFuture<Empty> importFacebookFriends(@NonNull final Session session, @NonNull final String token);

  /**
   * Import Facebook friends and add them to the user's account.
   *
   * The server will import friends when the user authenticates with Facebook. This function can be used to be
   * explicit with the import operation.
   *
   * @param session The session of the user.
   * @param token An OAuth access token from the Facebook SDK.
   * @param reset True if the Facebook friend import for the user should be reset.
   * @return A future.
   */
  ListenableFuture<Empty> importFacebookFriends(@NonNull final Session session, @NonNull final String token, final boolean reset);

  /**
   * Join a group if it has open membership or request to join it.
   *
   * @param session The session of the user.
   * @param groupId The id of the group to join.
   * @return A future.
   */
  ListenableFuture<Empty> joinGroup(@NonNull final Session session, @NonNull final String groupId);

  /**
   * Join a group if it has open membership or request to join it.
   *
   * @param session The session of the user.
   * @param tournamentId The id of the tournament to join.
   * @return A future.
   */
  ListenableFuture<Empty> joinTournament(@NonNull final Session session, @NonNull final String tournamentId);

  /**
   * Kick one or more users from the group.
   *
   * @param session The session of the user.
   * @param groupId The id of the group.
   * @param ids The ids of the users to kick.
   * @return A future.
   */
  ListenableFuture<Empty> kickGroupUsers(@NonNull final Session session, @NonNull final String groupId, @NonNull final String... ids);

  /**
   * Leave a group by id.
   *
   * @param session The session of the user.
   * @param groupId The id of the group to leave.
   * @return A future.
   */
  ListenableFuture<Empty> leaveGroup(@NonNull final Session session, @NonNull final String groupId);

  /**
   * Link a custom id to the user account owned by the session.
   *
   * @param session The session of the user.
   * @param id A custom identifier usually obtained from an external authentication service.
   * @return A future.
   */
  ListenableFuture<Empty> linkCustom(@NonNull final Session session, @NonNull final String id);

  /**
   * Link a device id to the user account owned by the session.
   *
   * @param session The session of the user.
   * @param id A device identifier usually obtained from a platform API.
   * @return A future.
   */
  ListenableFuture<Empty> linkDevice(@NonNull final Session session, @NonNull final String id);

  /**
   * Link an email with password to the user account owned by the session.
   *
   * @param session The session of the user.
   * @param email The email address of the user.
   * @param password The password for the user.
   * @return A future.
   */
  ListenableFuture<Empty> linkEmail(@NonNull final Session session, @NonNull final String email, @NonNull final String password);

  /**
   * Link a Facebook profile to a user account.
   *
   * @param session The session of the user.
   * @param accessToken An OAuth access token from the Facebook SDK.
   * @return A future.
   */
  ListenableFuture<Empty> linkFacebook(@NonNull final Session session, @NonNull final String accessToken);

  /**
   * Link a Facebook profile to a user account.
   *
   * @param session The session of the user.
   * @param accessToken An OAuth access token from the Facebook SDK.
   * @param importFriends True if the Facebook friends should be imported.
   * @return A future.
   */
  ListenableFuture<Empty> linkFacebook(@NonNull final Session session, @NonNull final String accessToken, final boolean importFriends);

  /**
   * Link a Google profile to a user account.
   *
   * @param session The session of the user.
   * @param accessToken An OAuth access token from the Google SDK.
   * @return A future.
   */
  ListenableFuture<Empty> linkGoogle(@NonNull final Session session, @NonNull final String accessToken);

  /**
   * Link a Steam profile to a user account.
   *
   * @param session The session of the user.
   * @param token An authentication token from the Steam network.
   * @return A future.
   */
  ListenableFuture<Empty> linkSteam(@NonNull final Session session, @NonNull final String token);

  /**
   * Link a Game Center profile to a user account.
   *
   * @param session The session of the user.
   * @param playerId The player id of the user in Game Center.
   * @param bundleId The bundle id of the Game Center application.
   * @param timestampSeconds The date and time that the signature was created.
   * @param salt A random <c>NSString</c> used to compute the hash and keep it randomized.
   * @param signature The verification signature data generated.
   * @param publicKeyUrl The URL for the public encryption key.
   * @return A future.
   */
  ListenableFuture<Empty> linkGameCenter(@NonNull final Session session, @NonNull final String playerId, @NonNull final String bundleId, final long timestampSeconds, @NonNull final String salt, @NonNull final String signature, @NonNull final String publicKeyUrl);

  /**
   * List messages from a chat channel.
   *
   * @param session The session of the user.
   * @param channelId A channel identifier.
   * @return A future to resolve channel message objects.
   */
  ListenableFuture<ChannelMessageList> listChannelMessages(@NonNull final Session session, @NonNull final String channelId);

  /**
   * List messages from a chat channel.
   *
   * @param session The session of the user.
   * @param channelId A channel identifier.
   * @param limit The number of chat messages to list.
   * @return A future to resolve channel message objects.
   */
  ListenableFuture<ChannelMessageList> listChannelMessages(@NonNull final Session session, @NonNull final String channelId, final int limit);

  /**
   * List messages from a chat channel.
   *
   * @param session The session of the user.
   * @param channelId A channel identifier.
   * @param limit The number of chat messages to list.
   * @param cursor A cursor for the current position in the messages history to list.
   * @return A future to resolve channel message objects.
   */
  ListenableFuture<ChannelMessageList> listChannelMessages(@NonNull final Session session, @NonNull final String channelId, final int limit, final String cursor);

  /**
   * List messages from a chat channel.
   *
   * @param session The session of the user.
   * @param channelId A channel identifier.
   * @param limit The number of chat messages to list.
   * @param forward Fetch messages forward from the current cursor (or the start).
   * @param cursor A cursor for the current position in the messages history to list.
   * @return A future to resolve channel message objects.
   */
  ListenableFuture<ChannelMessageList> listChannelMessages(@NonNull final Session session, @NonNull final String channelId, final int limit, final String cursor, final boolean forward);

  /**
   * List of friends of the current user.
   *
   * @param session The session of the user.
   * @return A future to resolve friend objects.
   */
  ListenableFuture<Friends> listFriends(@NonNull final Session session);

  /**
   * List all users part of the group.
   *
   * @param session The session of the user.
   * @param groupId The id of the group.
   * @return A future to resolve group user objects.
   */
  ListenableFuture<GroupUserList> listGroupUsers(@NonNull final Session session, @NonNull final String groupId);

  /**
   * List groups on the server.
   *
   * @param session The session of the user.
   * @param name The name filter to apply to the group list.
   * @return A future to resolve group objects.
   */
  ListenableFuture<GroupList> listGroups(@NonNull final Session session, @NonNull final String name);

  /**
   * List groups on the server.
   *
   * @param session The session of the user.
   * @param name The name filter to apply to the group list.
   * @param limit The number of groups to list.
   * @return A future to resolve group objects.
   */
  ListenableFuture<GroupList> listGroups(@NonNull final Session session, @NonNull final String name, final int limit);

  /**
   * List groups on the server.
   *
   * @param session The session of the user.
   * @param name The name filter to apply to the group list.
   * @param limit The number of groups to list.
   * @param cursor A cursor for the current position in the groups to list.
   * @return A future to resolve group objects.
   */
  ListenableFuture<GroupList> listGroups(@NonNull final Session session, final String name, final int limit, final String cursor);

  /**
   * List records from a leaderboard.
   *
   * @param session The session of the user.
   * @param leaderboardId The id of the leaderboard to list.
   * @return A future to resolve leaderboard record objects.
   */
  ListenableFuture<LeaderboardRecordList> listLeaderboardRecords(@NonNull final Session session, @NonNull final String leaderboardId);

  /**
   * List records from a leaderboard.
   *
   * @param session The session of the user.
   * @param leaderboardId The id of the leaderboard to list.
   * @param ownerIds Record owners to fetch with the list of records.
   * @return A future to resolve leaderboard record objects.
   */
  ListenableFuture<LeaderboardRecordList> listLeaderboardRecords(@NonNull final Session session, @NonNull final String leaderboardId, final String... ownerIds);

  /**
   * List records from a leaderboard.
   *
   * @param session The session of the user.
   * @param leaderboardId The id of the leaderboard to list.
   * @param ownerIds Record owners to fetch with the list of records.
   * @param limit The number of records to list.
   * @return A future to resolve leaderboard record objects.
   */
  ListenableFuture<LeaderboardRecordList> listLeaderboardRecords(@NonNull final Session session, @NonNull final String leaderboardId, final Iterable<String> ownerIds, final int limit);

  /**
   * List records from a leaderboard.
   *
   * @param session The session of the user.
   * @param leaderboardId The id of the leaderboard to list.
   * @param ownerIds Record owners to fetch with the list of records.
   * @param limit The number of records to list.
   * @param cursor A cursor for the current position in the leaderboard records to list.
   * @return A future to resolve leaderboard record objects.
   */
  ListenableFuture<LeaderboardRecordList> listLeaderboardRecords(@NonNull final Session session, @NonNull final String leaderboardId, final Iterable<String> ownerIds, final int limit, final String cursor);

  /**
   * List leaderboard records from a given leaderboard around the owner.
   * @param session The session of the user.
   * @param leaderboardId The id of the leaderboard to list.
   * @param ownerId The owner to retrieve records around.
   * @return A future to resolve leaderboard record objects.
   */
  ListenableFuture<LeaderboardRecordList> listLeaderboardRecordsAroundOwner(@NonNull final Session session, @NonNull final String leaderboardId, @NonNull final String ownerId);

  /**
   * List leaderrboard records from a given leaderboard around the owner.
   * @param session The session of the user.
   * @param leaderboardId The id of the leaderboard to list.
   * @param ownerId The owner to retrieve records around.
   * @param limit Max number of records to return. Between 1 and 100.
   * @return A future to resolve leaderboard record objects.
   */
  ListenableFuture<LeaderboardRecordList> listLeaderboardRecordsAroundOwner(@NonNull final Session session, @NonNull final String leaderboardId, @NonNull final String ownerId, final int limit);

  /**
   * Fetch a list of matches active on the server.
   *
   * @param session The session of the user.
   * @return A future to resolve match.
   */
  ListenableFuture<MatchList> listMatches(@NonNull final Session session);

  /**
   * Fetch a list of matches active on the server.
   *
   * @param session The session of the user.
   * @param min The minimum number of match participants.
   * @return A future to resolve match.
   */
  ListenableFuture<MatchList> listMatches(@NonNull final Session session, final int min);

  /**
   * Fetch a list of matches active on the server.
   *
   * @param session The session of the user.
   * @param min The minimum number of match participants.
   * @param max The maximum number of match participants.
   * @return A future to resolve match.
   */
  ListenableFuture<MatchList> listMatches(@NonNull final Session session, final int min, final int max);

  /**
   * Fetch a list of matches active on the server.
   *
   * @param session The session of the user.
   * @param min The minimum number of match participants.
   * @param max The maximum number of match participants.
   * @param limit The number of matches to list.
   * @return A future to resolve match.
   */
  ListenableFuture<MatchList> listMatches(@NonNull final Session session, final int min, final int max, final int limit);

  /**
   * Fetch a list of matches active on the server.
   *
   * @param session The session of the user.
   * @param min The minimum number of match participants.
   * @param max The maximum number of match participants.
   * @param limit The number of matches to list.
   * @param label The label to filter the match list on.
   * @return A future to resolve match.
   */
  ListenableFuture<MatchList> listMatches(@NonNull final Session session, final int min, final int max, final int limit, final String label);

  /**
   * Fetch a list of matches active on the server.
   *
   * @param session The session of the user.
   * @param min The minimum number of match participants.
   * @param max The maximum number of match participants.
   * @param limit The number of matches to list.
   * @param authoritative <c>True</c> to include authoritative matches.
   * @param label The label to filter the match list on.
   * @return A future to resolve match.
   */
  ListenableFuture<MatchList> listMatches(@NonNull final Session session, final int min, final int max, final int limit, final String label, final boolean authoritative);

  /**
   * List notifications for the user with an optional cursor.
   *
   * @param session The session of the user.
   * @return A future to resolve notifications objects.
   */
  ListenableFuture<com.heroiclabs.nakama.api.NotificationList> listNotifications(@NonNull final Session session);

  /**
   * List notifications for the user with an optional cursor.
   *
   * @param session The session of the user.
   * @param limit The number of notifications to list.
   * @return A future to resolve notifications objects.
   */
  ListenableFuture<com.heroiclabs.nakama.api.NotificationList> listNotifications(@NonNull final Session session, final int limit);

  /**
   * List notifications for the user with an optional cursor.
   *
   * @param session The session of the user.
   * @param limit The number of notifications to list.
   * @param cacheableCursor A cursor for the current position in notifications to list.
   * @return A future to resolve notifications objects.
   */
  ListenableFuture<com.heroiclabs.nakama.api.NotificationList> listNotifications(@NonNull final Session session, final int limit, final String cacheableCursor);

  /**
   * List storage objects in a collection which have public read access.
   *
   * @param session The session of the user.
   * @param collection The collection to list over.
   * @return A future which resolves to a storage object list.
   */
  ListenableFuture<StorageObjectList> listStorageObjects(@NonNull final Session session, @NonNull final String collection);

  /**
   * List storage objects in a collection which have public read access.
   *
   * @param session The session of the user.
   * @param collection The collection to list over.
   * @param limit The number of objects to list.
   * @return A future which resolves to a storage object list.
   */
  ListenableFuture<StorageObjectList> listStorageObjects(@NonNull final Session session, @NonNull final String collection, final int limit);

  /**
   * List storage objects in a collection which have public read access.
   *
   * @param session The session of the user.
   * @param collection The collection to list over.
   * @param limit The number of objects to list.
   * @param cursor A cursor to paginate over the collection.
   * @return A future which resolves to a storage object list.
   */
  ListenableFuture<StorageObjectList> listStorageObjects(@NonNull final Session session, @NonNull final String collection, final int limit, final String cursor);

  /**
   * List active/upcoming tournaments based on given filters.
   * @param session The session of the user.
   * @return a future which resolved to a tournament list.
   */
  ListenableFuture<TournamentList> listTournaments(@NonNull final Session session);

  /**
   * List active/upcoming tournaments based on given filters.
   * @param session The session of the user.
   * @param full Include tournaments that are full with players.
   * @param limit Max number of records to return. Between 1 and 100.
   * @param cursor A next page cursor for listings.
   * @return a future which resolved to a tournament list.
   */
  ListenableFuture<TournamentList> listTournaments(@NonNull final Session session, final int limit, final String cursor);

  /**
   * List active/upcoming tournaments based on given filters.
   * @param session The session of the user.
   * @param categoryStart The start of the categories to include. Defaults to 0.
   * @return a future which resolved to a tournament list.
   */
  ListenableFuture<TournamentList> listTournaments(@NonNull final Session session, final int categoryStart);

  /**
   * List active/upcoming tournaments based on given filters.
   * @param session The session of the user.
   * @param categoryStart The start of the categories to include. Defaults to 0.
   * @param categoryEnd The end of the categories to include. Defaults to 128.
   * @return a future which resolved to a tournament list.
   */
  ListenableFuture<TournamentList> listTournaments(@NonNull final Session session, final int categoryStart, final int categoryEnd);

  /**
   * List active/upcoming tournaments based on given filters.
   * @param session The session of the user.
   * @param categoryStart The start of the categories to include. Defaults to 0.
   * @param categoryEnd The end of the categories to include. Defaults to 128.
   * @param startTime The start time for tournaments. Defaults to current Unix time.
   * @return a future which resolved to a tournament list.
   */
  ListenableFuture<TournamentList> listTournaments(@NonNull final Session session, final int categoryStart, final int categoryEnd, final long startTime);

  /**
   * List active/upcoming tournaments based on given filters.
   * @param session The session of the user.
   * @param categoryStart The start of the categories to include. Defaults to 0.
   * @param categoryEnd The end of the categories to include. Defaults to 128.
   * @param startTime The start time for tournaments. Defaults to current Unix time.
   * @param endTime The end time for tournaments. Defaults to +1 year from current Unix time.
   * @return a future which resolved to a tournament list.
   */
  ListenableFuture<TournamentList> listTournaments(@NonNull final Session session, final int categoryStart, final int categoryEnd, final long startTime, final long endTime);

  /**
   * List active/upcoming tournaments based on given filters.
   * @param session The session of the user.
   * @param categoryStart The start of the categories to include. Defaults to 0.
   * @param categoryEnd The end of the categories to include. Defaults to 128.
   * @param startTime The start time for tournaments. Defaults to current Unix time.
   * @param endTime The end time for tournaments. Defaults to +1 year from current Unix time.
   * @param limit Max number of records to return. Between 1 and 100.
   * @param cursor A next page cursor for listings.
   * @return a future which resolved to a tournament list.
   */
  ListenableFuture<TournamentList> listTournaments(@NonNull final Session session, final int categoryStart, final int categoryEnd, final long startTime, final long endTime, final int limit, final String cursor);

  /**
   * List tournament records from a given tournament.
   * @param session The session of the user.
   * @param tournamentId The ID of the tournament to list for.
   * @return a future which resolved to a tournament record list.
   */
  ListenableFuture<TournamentRecordList> listTournamentRecords(@NonNull final Session session, @NonNull final String tournamentId);

  /**
   * List tournament records from a given tournament.
   * @param session The session of the user.
   * @param tournamentId The ID of the tournament to list for.
   * @param limit Max number of records to return. Between 1 and 100.
   * @param cursor A next or previous page cursor.
   * @return a future which resolved to a tournament record list.
   */
  ListenableFuture<TournamentRecordList> listTournamentRecords(@NonNull final Session session, @NonNull final String tournamentId, final int limit, final String cursor);

  /**
   * List tournament records from a given tournament.
   * @param session The session of the user.
   * @param tournamentId The ID of the tournament to list for.
   * @param ownerIds One or more owners to retrieve records for.
   * @return a future which resolved to a tournament record list.
   */
  ListenableFuture<TournamentRecordList> listTournamentRecords(@NonNull final Session session, @NonNull final String tournamentId, @NonNull final String... ownerIds);

  /**
   * List tournament records from a given tournament.
   * @param session The session of the user.
   * @param tournamentId The ID of the tournament to list for.
   * @param limit Max number of records to return. Between 1 and 100.
   * @param cursor A next or previous page cursor.
   * @param ownerIds One or more owners to retrieve records for.
   * @return a future which resolved to a tournament record list.
   */
  ListenableFuture<TournamentRecordList> listTournamentRecords(@NonNull final Session session, @NonNull final String tournamentId, final int limit, final String cursor, @NonNull final String... ownerIds);

  /**
   * List tournament records from a given tournament around the owner.
   * @param session The session of the user.
   * @param tournamentId The ID of the tournament to list for.
   * @param ownerId The owner to retrieve records around.
   * @return A future to resolve tournament record objects.
   */
  ListenableFuture<TournamentRecordList> listTournamentRecordsAroundOwner(@NonNull final Session session, @NonNull final String tournamentId, @NonNull final String ownerId);

  /**
   * List tournament records from a given tournament around the owner.
   * @param session The session of the user.
   * @param tournamentId The ID of the tournament to list for.
   * @param ownerId The owner to retrieve records around.
   * @param limit Max number of records to return. Between 1 and 100.
   * @return A future to resolve tournament record objects.
   */
  ListenableFuture<TournamentRecordList> listTournamentRecordsAroundOwner(@NonNull final Session session, @NonNull final String tournamentId, @NonNull final String ownerId, final int limit);

  /**
   * List of groups the current user is a member of.
   *
   * @param session The session of the user.
   * @return A future which resolves to group objects.
   */
  ListenableFuture<UserGroupList> listUserGroups(@NonNull final Session session);

  /**
   * List groups a user is a member of.
   *
   * @param session The session of the user.
   * @param userId The id of the user whose groups to list.
   * @return A future which resolves to group objects.
   */
  ListenableFuture<UserGroupList> listUserGroups(@NonNull final Session session, final String userId);

  /**
   * List storage objects in a collection which belong to a specific user and have public read access.
   *
   * @param session The session of the user.
   * @param collection The collection to list over.
   * @param userId The user ID of the user to list objects for.
   * @return A future which resolves to a storage object list.
   */
  ListenableFuture<StorageObjectList> listUsersStorageObjects(@NonNull final Session session, @NonNull final String collection, final String userId);

  /**
   * List storage objects in a collection which belong to a specific user and have public read access.
   *
   * @param session The session of the user.
   * @param collection The collection to list over.
   * @param userId The user ID of the user to list objects for.
   * @param limit The number of objects to list.
   * @return A future which resolves to a storage object list.
   */
  ListenableFuture<StorageObjectList> listUsersStorageObjects(@NonNull final Session session, @NonNull final String collection, final String userId, final int limit);

  /**
   * List storage objects in a collection which belong to a specific user and have public read access.
   *
   * @param session The session of the user.
   * @param collection The collection to list over.
   * @param userId The user ID of the user to list objects for.
   * @param limit The number of objects to list.
   * @param cursor A cursor to paginate over the collection.
   * @return A future which resolves to a storage object list.
   */
  ListenableFuture<StorageObjectList> listUsersStorageObjects(@NonNull final Session session, @NonNull final String collection, final String userId, final int limit, final String cursor);

  /**
   * Promote one or more users in the group.
   *
   * @param session The session of the user.
   * @param groupId The id of the group to promote users into.
   * @param ids The ids of the users to promote.
   * @return A future.
   */
  ListenableFuture<Empty> promoteGroupUsers(@NonNull final Session session, @NonNull final String groupId, @NonNull final String... ids);

  /**
   * Read one or more objects from the storage engine.
   *
   * @param session The session of the user.
   * @param objectIds The objects to read.
   * @return A future to resolve storage objects.
   */
  ListenableFuture<StorageObjects> readStorageObjects(@NonNull final Session session, @NonNull final StorageObjectId... objectIds);

  /**
   * Execute a Lua function with an input payload on the server.
   *
   * @param session The session of the user.
   * @param id The id of the function to execute on the server.
   * @return A future to resolve an RPC response.
   */
  ListenableFuture<Rpc> rpc(@NonNull final Session session, @NonNull final String id);

  /**
   * Execute a Lua function with an input payload on the server.
   *
   * @param session The session of the user.
   * @param id The id of the function to execute on the server.
   * @param payload The payload to send with the function call.
   * @return A future to resolve an RPC response.
   */
  ListenableFuture<Rpc> rpc(@NonNull final Session session, @NonNull final String id, final String payload);

//    TODO(mo): Is this still needed from the client / doable using gRPC?
//    ListenableFuture<Rpc> rpc(@NonNull final String httpKey, @NonNull final String id);
//    ListenableFuture<Rpc> rpc(@NonNull final String httpKey, @NonNull final String id, @NonNull final String payload);

  /**
   * Unlink a custom id from the user account owned by the session.
   *
   * @param session The session of the user.
   * @param id A custom identifier usually obtained from an external authentication service.
   * @return A future.
   */
  ListenableFuture<Empty> unlinkCustom(@NonNull final Session session, @NonNull final String id);

  /**
   * Unlink a device id from the user account owned by the session.
   *
   * @param session The session of the user.
   * @param id A device identifier usually obtained from a platform API.
   * @return A future.
   */
  ListenableFuture<Empty> unlinkDevice(@NonNull final Session session, @NonNull final String id);

  /**
   * Unlink an email with password from the user account owned by the session.
   *
   * @param session The session of the user.
   * @param email The email address of the user.
   * @param password The password for the user.
   * @return A future.
   */
  ListenableFuture<Empty> unlinkEmail(@NonNull final Session session, @NonNull final String email, @NonNull final String password);

  /**
   * Unlink a Facebook profile from the user account owned by the session.
   *
   * @param session The session of the user.
   * @param accessToken An OAuth access token from the Facebook SDK.
   * @return A future.
   */
  ListenableFuture<Empty> unlinkFacebook(@NonNull final Session session, @NonNull final String accessToken);

  /**
   * Unlink a Google profile from the user account owned by the session.
   *
   * @param session The session of the user.
   * @param accessToken An OAuth access token from the Google SDK.
   * @return A future.
   */

  ListenableFuture<Empty> unlinkGoogle(@NonNull final Session session, @NonNull final String accessToken);

  /**
   * Unlink a Steam profile from the user account owned by the session.
   *
   * @param session The session of the user.
   * @param token An authentication token from the Steam network.
   * @return A future.
   */
  ListenableFuture<Empty> unlinkSteam(@NonNull final Session session, @NonNull final String token);

  /**
   * Unlink a Game Center profile from the user account owned by the session.
   *
   * @param session The session of the user.
   * @param playerId The player id of the user in Game Center.
   * @param bundleId The bundle id of the Game Center application.
   * @param timestampSeconds The date and time that the signature was created.
   * @param salt A random <c>NSString</c> used to compute the hash and keep it randomized.
   * @param signature The verification signature data generated.
   * @param publicKeyUrl The URL for the public encryption key.
   * @return A future.
   */
  ListenableFuture<Empty> unlinkGameCenter(@NonNull final Session session, @NonNull final String playerId, @NonNull final String bundleId, final long timestampSeconds, @NonNull final String salt, @NonNull final String signature, @NonNull final String publicKeyUrl);

  /**
   * Update the current user's account on the server.
   *
   * @param session The session for the user.
   * @param username The new username for the user.
   * @return A future to complete the account update.
   */
  ListenableFuture<Empty> updateAccount(@NonNull final Session session, final String username);

  /**
   * Update the current user's account on the server.
   *
   * @param session The session for the user.
   * @param username The new username for the user.
   * @param displayName A new display name for the user.
   * @return A future to complete the account update.
   */
  ListenableFuture<Empty> updateAccount(@NonNull final Session session, final String username, final String displayName);

  /**
   * Update the current user's account on the server.
   *
   * @param session The session for the user.
   * @param username The new username for the user.
   * @param displayName A new display name for the user.
   * @param avatarUrl A new avatar url for the user.
   * @return A future to complete the account update.
   */
  ListenableFuture<Empty> updateAccount(@NonNull final Session session, final String username, final String displayName, final String avatarUrl);

  /**
   * Update the current user's account on the server.
   *
   * @param session The session for the user.
   * @param username The new username for the user.
   * @param displayName A new display name for the user.
   * @param avatarUrl A new avatar url for the user.
   * @param langTag A new language tag in BCP-47 format for the user.
   * @return A future to complete the account update.
   */
  ListenableFuture<Empty> updateAccount(@NonNull final Session session, final String username, final String displayName, final String avatarUrl, final String langTag);

  /**
   * Update the current user's account on the server.
   *
   * @param session The session for the user.
   * @param username The new username for the user.
   * @param displayName A new display name for the user.
   * @param avatarUrl A new avatar url for the user.
   * @param langTag A new language tag in BCP-47 format for the user.
   * @param location A new location for the user.
   * @return A future to complete the account update.
   */
  ListenableFuture<Empty> updateAccount(@NonNull final Session session, final String username, final String displayName, final String avatarUrl, final String langTag, final String location);

  /**
   * Update the current user's account on the server.
   *
   * @param session The session for the user.
   * @param username The new username for the user.
   * @param displayName A new display name for the user.
   * @param avatarUrl A new avatar url for the user.
   * @param langTag A new language tag in BCP-47 format for the user.
   * @param location A new location for the user.
   * @param timezone New timezone information for the user.
   * @return A future to complete the account update.
   */
  ListenableFuture<Empty> updateAccount(@NonNull final Session session, final String username, final String displayName, final String avatarUrl, final String langTag, final String location, final String timezone);

  /**
   * Update a group.
   *
   * The user must have the correct access permissions for the group.
   *
   * @param session The session of the user.
   * @param groupId The id of the group to update.
   * @param name A new name for the group.
   * @return A future.
   */
  ListenableFuture<Empty> updateGroup(@NonNull final Session session, @NonNull final String groupId, final String name);

  /**
   * Update a group.
   *
   * The user must have the correct access permissions for the group.
   *
   * @param session The session of the user.
   * @param groupId The id of the group to update.
   * @param name A new name for the group.
   * @param description A new description for the group.
   * @return A future.
   */
  ListenableFuture<Empty> updateGroup(@NonNull final Session session, @NonNull final String groupId, final String name, final String description);

  /**
   * Update a group.
   *
   * The user must have the correct access permissions for the group.
   *
   * @param session The session of the user.
   * @param groupId The id of the group to update.
   * @param name A new name for the group.
   * @param description A new description for the group.
   * @param avatarUrl A new avatar url for the group.
   * @return A future.
   */
  ListenableFuture<Empty> updateGroup(@NonNull final Session session, @NonNull final String groupId, final String name, final String description, final String avatarUrl);

  /**
   * Update a group.
   *
   * The user must have the correct access permissions for the group.
   *
   * @param session The session of the user.
   * @param groupId The id of the group to update.
   * @param name A new name for the group.
   * @param description A new description for the group.
   * @param avatarUrl A new avatar url for the group.
   * @param langTag A new language tag in BCP-47 format for the group.
   * @return A future.
   */
  ListenableFuture<Empty> updateGroup(@NonNull final Session session, @NonNull final String groupId, final String name, final String description, final String avatarUrl, final String langTag);

  /**
   * Update a group.
   *
   * The user must have the correct access permissions for the group.
   *
   * @param session The session of the user.
   * @param groupId The id of the group to update.
   * @param name A new name for the group.
   * @param description A new description for the group.
   * @param avatarUrl A new avatar url for the group.
   * @param langTag A new language tag in BCP-47 format for the group.
   * @param open True if the group should have open membership.
   * @return A future.
   */
  ListenableFuture<Empty> updateGroup(@NonNull final Session session, @NonNull final String groupId, final String name, final String description, final String avatarUrl, final String langTag, final boolean open);

  /**
   * Write a record to a leaderboard.
   *
   * @param session The session for the user.
   * @param leaderboardId The id of the leaderboard to write.
   * @param score The score for the leaderboard record.
   * @return A future to complete the leaderboard record write.
   */
  ListenableFuture<LeaderboardRecord> writeLeaderboardRecord(@NonNull final Session session, @NonNull final String leaderboardId, final long score);

  /**
   * Write a record to a leaderboard.
   *
   * @param session The session for the user.
   * @param leaderboardId The id of the leaderboard to write.
   * @param score The score for the leaderboard record.
   * @param subscore The subscore for the leaderboard record.
   * @return A future to complete the leaderboard record write.
   */
  ListenableFuture<LeaderboardRecord> writeLeaderboardRecord(@NonNull final Session session, @NonNull final String leaderboardId, final long score, final long subscore);

  /**
   * Write a record to a leaderboard.
   *
   * @param session The session for the user.
   * @param leaderboardId The id of the leaderboard to write.
   * @param score The score for the leaderboard record.
   * @param metadata The metadata for the leaderboard record.
   * @return A future to complete the leaderboard record write.
   */
  ListenableFuture<LeaderboardRecord> writeLeaderboardRecord(@NonNull final Session session, @NonNull final String leaderboardId, final long score, final String metadata);

  /**
   * Write a record to a leaderboard.
   *
   * @param session The session for the user.
   * @param leaderboardId The id of the leaderboard to write.
   * @param score The score for the leaderboard record.
   * @param subscore The subscore for the leaderboard record.
   * @param metadata The metadata for the leaderboard record.
   * @return A future to complete the leaderboard record write.
   */
  ListenableFuture<LeaderboardRecord> writeLeaderboardRecord(@NonNull final Session session, @NonNull final String leaderboardId, final long score, final long subscore, final String metadata);

  /**
   * Write objects to the storage engine.
   *
   * @param session The session of the user.
   * @param objects The objects to write.
   * @return A future to resolve the acknowledgements with writes.
   */
  ListenableFuture<StorageObjectAcks> writeStorageObjects(@NonNull final Session session, @NonNull final StorageObjectWrite... objects);

  /**
   * A request to submit a score to a tournament.
   *
   * @param session The session for the user.
   * @param tournamentId The tournament ID to write the record for.
   * @param score The score value to submit.
   * @return A future to complete the tournament record write.
   */
  ListenableFuture<LeaderboardRecord> writeTournamentRecord(@NonNull final Session session, @NonNull final String tournamentId, final long score);

  /**
   * A request to submit a score to a tournament.
   *
   * @param session The session for the user.
   * @param tournamentId The tournament ID to write the record for.
   * @param score The score value to submit.
   * @param subscore An optional secondary value.
   * @return A future to complete the tournament record write.
   */
  ListenableFuture<LeaderboardRecord> writeTournamentRecord(@NonNull final Session session, @NonNull final String tournamentId, final long score, final long subscore);

  /**
   * A request to submit a score to a tournament.
   *
   * @param session The session for the user.
   * @param tournamentId The tournament ID to write the record for.
   * @param score The score value to submit.
   * @param metadata A JSON object of additional properties.
   * @return A future to complete the tournament record write.
   */
  ListenableFuture<LeaderboardRecord> writeTournamentRecord(@NonNull final Session session, @NonNull final String tournamentId, final long score, final String metadata);

  /**
   * A request to submit a score to a tournament.
   *
   * @param session The session for the user.
   * @param tournamentId The tournament ID to write the record for.
   * @param score The score value to submit.
   * @param subscore  An optional secondary value.
   * @param metadata A JSON object of additional properties.
   * @return A future to complete the tournament record write.
   */
  ListenableFuture<LeaderboardRecord> writeTournamentRecord(@NonNull final Session session, @NonNull final String tournamentId, final long score, final long subscore, final String metadata);
}