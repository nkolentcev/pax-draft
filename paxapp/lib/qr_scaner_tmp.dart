import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'models/bpass_model.dart';

class QRScanerTMP extends StatefulWidget {
  const QRScanerTMP({super.key});

  @override
  State<QRScanerTMP> createState() => QRScanerState();
}

class QRScanerState extends State<QRScanerTMP> {
  String _barcodeString = "";
  var colorRed = Colors.red;
  var colorGreen = Colors.green;
  Color _color = Colors.transparent;
  bool _swap = false;
  String _info = "";
  String _testString =
      "M1AMREYEVA/ZAURE      E17KJF1 ALAKSNKC 7141 039Y010B0004 100";
  BPass _bpass = BPass(
      type: "",
      firstName: "",
      lastName: "",
      booking: "",
      fullflight: "",
      flightnumber: "",
      codes: "",
      cabin: "",
      formatedData: "",
      seat: "");

  @override
  Widget build(BuildContext context) {
    Widget swqpWidget = new Container();
    if (_swap) {
      swqpWidget = DataCard(barcodestring: _barcodeString, bpass: _bpass);
    } else {
      swqpWidget = new Container();
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Expanded(
                flex: 6,
                child: Container(
                    child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                  ),
                  child: MobileScanner(
                    // fit: BoxFit.contain,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      if (barcodes.length > 0) {
                        BPass bpass = readBarcode(barcodes[0].rawValue!);
                        setState(() {
                          _barcodeString = barcodes[0].rawValue!;
                          _color = colorGreen;
                          _bpass = bpass;
                          _swap = true;
                          _info = "успешная регистрация";
                        });
                      }
                    },
                  ),
                ))),
            Expanded(
                flex: 2,
                child: Container(
                  color: _color,
                  child: Center(
                    child: Column(
                      children: [Text('${_info}')],
                    ),
                  ),
                )),
            SizedBox(
              height: 4,
            ),
            Expanded(
                flex: 6,
                child: Container(
                  child: swqpWidget,
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey,
                ))
          ],
        ),
      ),
    );
  }
}

/// CARD
class DataCard extends StatefulWidget {
  final String barcodestring;
  final BPass bpass;
  DataCard({super.key, required this.barcodestring, required this.bpass});

  @override
  State<DataCard> createState() =>
      _DataCardState(this.barcodestring, this.bpass);
}

class _DataCardState extends State<DataCard> {
  String barcodestring = "";
  BPass bpass = BPass(
      type: "",
      firstName: "",
      lastName: "",
      booking: "",
      fullflight: "",
      flightnumber: "",
      codes: "",
      cabin: "",
      formatedData: "",
      seat: "");
  _DataCardState(this.barcodestring, this.bpass);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Column(
        children: [
          Row(
            children: [
              Text("Фамилия: "),
              Text(
                widget.bpass.lastName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text("Имя: "),
              Text(
                widget.bpass.firstName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text("рейс: "),
              Text(widget.bpass.flightnumber),
              Text(" к: "),
              Text(widget.bpass.cabin),
              Text(" место: "),
              Text(widget.bpass.seat),
            ],
          ),
        ],
      )),
    );
  }
}

BPass readBarcode(String barcode) {
  String fname = "";
  String lname = "";
  String booking = "";
  String fullflight = "";
  String flightnumber = "";
  String codes = "";
  String passtype = "";
  final pattern = "M1";
  final withoutType = barcode.replaceFirst(pattern, "");
  final arrStrings = withoutType.split(" ");
  final fio = arrStrings[0].split("/");
  if (fio.length > 1) {
    fname = fio[0].toString();
    lname = fio[1].toString();
  }
//4 параметра

  int kap = 0;
  for (int i = 1; i < arrStrings.length; i++) {
    if (arrStrings[i].length > 0) {
      kap++;
      switch (kap) {
        case 1:
          booking = arrStrings[i].toString();
          break;
        case 2:
          fullflight = arrStrings[i].toString();
          break;
        case 3:
          flightnumber = arrStrings[i].toString();
          break;
        case 4:
          codes = arrStrings[i].toString();
          break;
      }
    }
  }

  switch (codes.substring(3, 4)) {
    case "Y":
      passtype = "Эконом";
      break;
    case "F":
      passtype = "Первый";
      break;
    case "J":
      passtype = "Бизнес";
      break;
    default:
      passtype = "Эконом";
      break;
  }

  //первые три символа из кода = дни с начала года
  final newdata = DateTime.utc(2023, 1, 1);
  final dayint = int.parse(codes.substring(0, 3));
  final dur = Duration(days: dayint);
  final flydate = newdata.add(dur);

  final seat = codes.substring(4, 8);

  return BPass(
      type: pattern,
      firstName: fname,
      lastName: lname,
      booking: booking,
      fullflight: fullflight,
      flightnumber: flightnumber,
      cabin: passtype,
      codes: codes,
      formatedData: flydate.toString(),
      seat: seat);
}
