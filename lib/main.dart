import 'package:flutter/material.dart';
import 'package:healthChain/helperFunction.dart';
import 'package:healthChain/login.dart';
import 'package:healthChain/qrScanner.dart';
import'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.green[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String clientDetails = "";
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
      });
    }
    getClientDetails();
  }

  @override
  Widget build(BuildContext context) {
    // Map decodedClientDetails = jsonDecode(clientDetails);
    return MaterialApp(
       
      debugShowCheckedModeBanner: false,

      home: clientDetails!=null||clientDetails!="" ? QrScanner() : Login()
    );
  }
}
