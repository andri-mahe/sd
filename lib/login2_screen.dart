import 'package:flutter/material.dart';

class Login2Screen extends StatefulWidget {
  const Login2Screen({super.key});

  @override
  State<Login2Screen> createState() => _Login2ScreenState();
}

class _Login2ScreenState extends State<Login2Screen> {
  bool passwordtampil = true;

  menampilkanpassword() {
    setState(() {
      passwordtampil = !passwordtampil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: passwordtampil ? Colors.greenAccent : Colors.amber,
      body: Column(
        children: [
          TextField(),
          TextField(
            obscureText: passwordtampil,
            decoration: InputDecoration(
              labelText: "password",
              hintText: "masukkan password",
              prefixIcon: Icon(Icons.lock),
              suffix:
                  passwordtampil
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
            ),
          ),
          //if else sderhana pakai ? jika true : jika false
          ElevatedButton(
            onPressed: () {
              menampilkanpassword();
            },
            child: Text("tampil password"),
          ),
        ],
      ),
    );
  }
}
