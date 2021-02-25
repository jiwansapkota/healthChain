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
        title: Text('HealthChain App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              scanResult == ''
                  ? Text('',
                   style: TextStyle(backgroundColor: Color.fromRGBO(255, 255, 255, 0.85)),
                  )
                  : Text(scanResult,
                   style: TextStyle(backgroundColor: Color.fromRGBO(255, 255, 255, 0.85)),),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Click Here To Scan',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: scanQRCode,
              )
            ],
          ),
        ),
      ),
    );
  }
}