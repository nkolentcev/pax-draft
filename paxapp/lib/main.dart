import 'package:flutter/material.dart';
import 'package:paxapp/pincode_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      )),
      home: Scaffold(
        body: Center(
          child: PinCodeScreen(),
        ),
      ),
    );
  }
}
