import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Next Page'), backgroundColor: Colors.black),
      body: Center(
        child: Text('Belum buat sabar ya!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
