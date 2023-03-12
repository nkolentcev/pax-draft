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

    return Container(
        child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: widget.flightList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Color.fromARGB(255, 204, 195, 195))),
          child: ListTile(
            title: Center(
              child: Text(
                '${widget.flightList[index]}',
                style: TextStyle(fontSize: 14),
              ),
            ),
            onTap: () {
              print('${widget.flightList[index]}');
            },
          ),
        );
      },
    ));
  }
}

//KC7141
//U6-2842
//KC352