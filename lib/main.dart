import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'splash_screen.dart';
import 'theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(MenuController());
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barbershop App',
        theme: ThemeData.light().copyWith(useMaterial3: true),
        darkTheme: ThemeData.dark().copyWith(useMaterial3: true),
        themeMode:
            themeController.isLightMode.value
                ? ThemeMode.light
                : ThemeMode.dark,
        home: SplashScreen(),
      ),
    );
  }
}
