import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final isLightMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLightMode.value = _box.read('isLightMode') ?? false;
    Get.changeThemeMode(isLightMode.value ? ThemeMode.light : ThemeMode.dark);
  }

  void toggleTheme(bool value) {
    isLightMode.value = value;
    _box.write('isLightMode', value);
    Get.changeThemeMode(value ? ThemeMode.light : ThemeMode.dark);
  }
}
