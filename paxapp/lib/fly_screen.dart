import 'package:flutter/material.dart';

class FLyScreen extends StatefulWidget {
  List<String> flightList;
  FLyScreen(this.flightList);

  @override
  State<FLyScreen> createState() => _FLyScreenState();
}

class _FLyScreenState extends State<FLyScreen> {
  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    @override
    initState() {
      super.initState();
      selectedValue = widget.flightList.first;
    }

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Container(
          child: Row(
            children: [
              Radio(
                  value: widget.flightList[index],
                  groupValue: selectedValue,
                  onChanged: (s) {}),
              Text(widget.flightList[index])
            ],
          ),
        );
      },
      itemCount: widget.flightList.length,
    );
  }
}

//KC7141
//U6-2842
//KC352