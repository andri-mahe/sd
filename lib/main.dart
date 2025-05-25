import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'splash_screen.dart';
import 'theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://vgmixkvynowtsqheozwn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZnbWl4a3Z5bm93dHNxaGVvenduIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc1NDE4NTksImV4cCI6MjA2MzExNzg1OX0.JQY9qIRGlfp7DelzaZEkDlViltnqSx8njXdD9CFUx4s',
  );

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
