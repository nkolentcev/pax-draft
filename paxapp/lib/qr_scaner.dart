import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScaner extends StatefulWidget {
  const QRScaner({super.key});

  @override
  State<QRScaner> createState() => QRScanerState();
}

class QRScanerState extends State<QRScaner> {
  String _barcodeString = "";
  var colorRed = Colors.red;
  var colorGreen = Colors.green;
  Color _color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
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
                        setState(() {
                          _barcodeString = barcodes[0].rawValue!;
                          _color = colorGreen;
                        });
                      }
                    },
                  ),
                ))),
            Expanded(
                flex: 2,
                child: Container(
                  color: _color,
                )),
            SizedBox(
              height: 4,
            ),
            Expanded(
                flex: 6,
                child: Container(
                  child: Text('${_barcodeString}'),
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
