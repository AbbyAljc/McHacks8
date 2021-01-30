import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QRScannerScreen extends StatelessWidget {
  String _barcodeResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Scan QR'),
          onPressed: () => _scan(),
        ),
      ),
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('Nothing returned');
    } else {
      this._barcodeResult = barcode;
      print(_barcodeResult);
    }
  }
}