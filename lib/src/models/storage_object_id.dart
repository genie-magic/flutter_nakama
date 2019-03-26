/// An identifier for a storage object.
class StorageObjectId {
  /// The collection which stores the object.
  String _collection;

  /// The key of the object within the collection.
  String _key;

  /// The version hash of the object.
  String _version;

  /// The user owner of the object.
  String _userId;
}
