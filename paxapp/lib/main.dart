import 'package:flutter/material.dart';
import 'package:paxapp/pincode_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('userdata');

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
