class PermissionWrite {
  final int _value;

  const PermissionWrite._internal(this._value);

  @override
  String toString() {
    return 'PermissionRead.$_value';
  }

  static const NO_READ = const PermissionWrite._internal(0);
  static const OWNER_READ = const PermissionWrite._internal(1);

  int get value {
    return this._value;
  }
}