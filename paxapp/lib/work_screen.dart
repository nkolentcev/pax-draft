import 'package:flutter/material.dart';
import 'package:paxapp/fly_screen.dart';
import 'package:paxapp/qr_scaner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_model.dart';
import 'qr_scaner_tmp.dart';

const List<Widget> zones = <Widget>[
  Text('Общая'),
  Text('Чистая'),
  Text('Накопитель'),
  // Text('?? БОРТ ??'),
];

List<String> flightList = [
  'KC7141',
  'KC352',
  'U6-2842',
  'U0-БОРТ 1',
  '.VIP',
];

class WorkScreen extends StatefulWidget {
  final Users user;
  WorkScreen({super.key, required this.user});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  final List<bool> _selectedZones = <bool>[true, false, false];
  bool _swap = true;
  String _ssid = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _ssid = (prefs.getString('uschema') ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget swqpWidget = new Container();
    if (_swap) {
      swqpWidget = new Center(
        child: Column(children: [
          Center(child: Text("Рейс можно выбрать в зоне портала")),
          ElevatedButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => QRScaner());
                Navigator.push(context, route);
              },
              child: Center(child: Text("-> сканирование"))),
          ElevatedButton(
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (context) => QRScanerTMP());
                Navigator.push(context, route);
              },
              child: Center(child: Text("-> технический (временно)")))
        ]),
      );
    } else {
      swqpWidget = FLyScreen(flightList);
    }
    var swapTile = new ListTile(
      title: swqpWidget,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(Icons.alarm),
                            title: Text(widget.user.name),
                            subtitle: Text('$_ssid')),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Text('Рабочая зона'),
                    const SizedBox(height: 10),
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < _selectedZones.length; i++) {
                            _selectedZones[i] = i == index;
                          }
                          if (index == 2) {
                            _swap = false;
                          } else {
                            _swap = true;
                          }
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      selectedBorderColor: Colors.red[700],
                      selectedColor: Colors.white,
                      fillColor: Colors.red[200],
                      color: Colors.red[400],
                      constraints: const BoxConstraints(
                        minHeight: 60.0,
                        minWidth: 100.0,
                      ),
                      isSelected: _selectedZones,
                      children: zones,
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            Expanded(flex: 8, child: swapTile)
          ],
        ),
      ),
    );
  }
}
