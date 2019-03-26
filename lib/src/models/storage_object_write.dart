import 'permission_read.dart';
import 'permission_write.dart';

/// An identifier and values for a storage object.
class StorageObjectWrite {
  /// The collection which stores the object.
  String _collection;

  /// The key of the object within the collection.
  String _key;

  /// The actual content of the object. Must be JSON.
  String _value;

  /// Read permission of the object.
  PermissionRead permissionRead;

  /// Write permission of the object.
  PermissionWrite permissionWrite;

  /// The version hash of the object to check against the server.
  String version;
}
