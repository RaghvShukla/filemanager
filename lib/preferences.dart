import 'package:get_storage/get_storage.dart';

class Preferences{
  Preferences._();

  static final _preferences = GetStorage();
  static const _keyViewType = 'viewType';

  static setViewType(bool viewType) => _preferences.write(_keyViewType, viewType);
  static bool getViewType() => _preferences.read(_keyViewType) ?? true;
}