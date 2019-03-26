class PermissionRead {
  final int _value;

  const PermissionRead._internal(this._value);

  @override
  String toString() {
    return 'PermissionRead.$_value';
  }

  static const NO_READ = const PermissionRead._internal(0);
  static const OWNER_READ = const PermissionRead._internal(1);
  static const PUBLIC_READ = const PermissionRead._internal(2);

  int get value {
    return this._value;
  }
}