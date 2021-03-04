import 'package:healthChain/details.dart';
import 'package:healthChain/login.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:healthChain/helperFunction.dart';
import 'dart:convert';

class QrScanner extends StatefulWidget {
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  String scanResult = "";
  String clientDetails;
  bool isLoading = true;

  void initState() {
    print("qr code initstate called");
    super.initState();
    getClientDetails() async {
      print('here is the details of orgatinationas');
      String receivedDetails =
          await HelperFunction.getClientDetailsPreference();
      print(receivedDetails);
      setState(() {
        clientDetails = receivedDetails;
        isLoading = false;
      });
    }

    getClientDetails();
  }

  //Logout button press handler
  logoutHandler() {
    HelperFunction.saveClientDetailsPreference("");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

//Qr code scanner function
  Future scanQRCode() async {
    String cameraScanResult = await scanner.scan();
    setState(() {
      scanResult = cameraScanResult;
      Constants.drugNumber = scanResult;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Details(scanResult)));
  }

  @override
  Widget build(BuildContext context) {
    print(
        'CLIENT DETIALS----------------------------------------------------------------------------');
    print(jsonDecode(clientDetails));
    print(
        'CLIENT DETAILS----------------------------------------------------------------------------');
    Map decodedClientDetails = jsonDecode(clientDetails);
    return Scaffold(
      drawer: !isLoading
          ? Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 400,
                    child: DrawerHeader(
                        child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/account.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              decodedClientDetails['organization'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          decodedClientDetails['organization'] != 'customer'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Peer",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          decodedClientDetails['organization'] != 'customer'
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      6.0, 0, 6.0, 6.0),
                                  child: Text(
                                    decodedClientDetails['peer'],
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          decodedClientDetails['organization'] != 'customer'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Certificate Authority",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          decodedClientDetails['organization'] != 'customer'
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      6.0, 0, 6.0, 6.0),
                                  child: Text(
                                    decodedClientDetails[
                                        'certificateAuthority'],
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                        ],
                      ),
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 480,
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("logout"),
                    onTap: logoutHandler,
                  ),
                ],
              ),
            )
          : Drawer(),
      appBar: AppBar(
        title: Text('HealthChain App'),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/bg_image.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/scan.png"),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 60,),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Click Here To Scan',
                  style: TextStyle(color: Colors.white),
                ),
                // onPressed: scanQRCode,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
