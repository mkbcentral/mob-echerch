import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = "IsDarkMode";
  _saveThemeToKey(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _loadThemeForBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeForBox() ? ThemeMode.dark : ThemeMode.light;

  void swichMode() {
    Get.changeThemeMode(_loadThemeForBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToKey(!_loadThemeForBox());
  }
}
