import 'dart:async';
import 'package:coba/login2_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'login2_screen.dart';
import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      String? username = box.read('username');
      String? password = box.read('password');
      if (username != null && password != null) {
        Get.off(() => MenuScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/logo.png', width: 250, height: 250),
      ),
    );
  }
}
