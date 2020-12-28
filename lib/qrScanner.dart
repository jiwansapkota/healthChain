import 'package:healthChain/details.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'constant.dart';

class QrScanner extends StatefulWidget {
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  String scanResult ="";
  Future scanQRCode()async{
    String cameraScanResult = await scanner.scan();
    setState(() {
      scanResult=cameraScanResult;
      Constants.drugNumber=scanResult;
    });
     Navigator.push(
              context, MaterialPageRoute(builder: (context) => Details(scanResult)));
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Scan Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            scanResult == ''
                ? Text('Result will be displayed here')
                : Text(scanResult),
            SizedBox(height: 20),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                'Click To Scan',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: scanQRCode,
            )
          ],
        ),
      ),
    );
  }
}