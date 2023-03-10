import 'package:flutter/material.dart';
import 'package:paxapp/fly_screen.dart';

import 'models/user_model.dart';

const List<Widget> zones = <Widget>[
  Text('Общая'),
  Text('Чистая'),
  Text('Портал'),
];

List<String> flightList = [
  'KC7141',
  'KC352',
  'U6-2842',
  '.список',
];

class WorkScreen extends StatefulWidget {
  final Users user;
  WorkScreen({super.key, required this.user});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  final List<bool> _selectedZones = <bool>[true, false, false];
  bool _swap = false;
  @override
  Widget build(BuildContext context) {
    Widget swqpWidget = new Container();
    if (_swap) {
      swqpWidget = new Text("Рейс можно выбрать в зоне портала");
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('${widget.user.name}'),
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
