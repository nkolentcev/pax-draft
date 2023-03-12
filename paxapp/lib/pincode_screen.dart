import 'package:flutter/material.dart';
import 'package:paxapp/models/user_model.dart';
import 'package:paxapp/work_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String _username = "";
  String _ssid = "";

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  //late Future<UserModeller> userModeller;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white60,
        body: GestureDetector(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Text("1"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'введите пин-код (табельный номер)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: PinCodeTextField(
                    appContext: context,
                    obscureText: true,
                    animationType: AnimationType.fade,
                    obscuringCharacter: "*",
                    keyboardType: TextInputType.number,
                    length: 6,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    onCompleted: (value) {
                      var pin = int.parse(value);
                      login(context, value);
                      setState(() {});
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    }),
              ),
            ],
          ),
        ));
  }
}

void login(BuildContext context, String pincode) async {
  try {
    Response response = await get(
      Uri.parse("http://213.27.32.24:8000/user/" + pincode),
    );
    if (response.statusCode == 200) {
      var userdata = jsonDecode(response.body.toString());
      Users user = Users(
          id: userdata['id'],
          name: userdata['name'],
          number: userdata['number'],
          uschema: userdata['uschema']);
      //hive
      _initUserData(user);
      //hive
      Route route =
          MaterialPageRoute(builder: (context) => WorkScreen(user: user));
      Navigator.push(context, route);
    } else {
      debugPrint("unable to connect");
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> _initUserData(Users user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("username", user.name);
  prefs.setString("ssid", user.id);
  prefs.setString("uschema", user.uschema);
}
