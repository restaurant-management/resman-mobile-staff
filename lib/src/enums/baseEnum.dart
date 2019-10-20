class BaseEnum {
  String value;
  List<String> listEnums;

  BaseEnum(String _value, List<String> _listEnums) {
    this.listEnums = _listEnums;
    if (listEnums.indexOf(_value) >= 0) {
      value = _value;
    }
  }

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is BaseEnum &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
