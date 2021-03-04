import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:healthChain/helperFunction.dart';
import 'package:healthChain/qrScanner.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

import 'constant.dart';

/// This is the stateful widget that the main application instantiates.
class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

/// This is the private State class that goes with Login.
class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool isSubmitting = false;
  PlatformFile file;
  String dropdownValue = 'Manufacturer';

  Future chooseFile() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile selectedFile = result.files.first;
        if (selectedFile.extension != 'json') {
          Fluttertoast.showToast(
              msg: "Please select config file!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          setState(() {
            file = selectedFile;
          });
        }
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print("error has occured");
      print(e);
    }
  }

  Future<dynamic> submitHandler() async {
    print("Entered getdata");
    setState(() {
      isSubmitting = true;
    });
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("${Constants.backendIp}/connection-profile"));
      request.fields['continueAs'] = dropdownValue;
      if (dropdownValue != 'Customer') {
        request.files.add(await http.MultipartFile.fromPath(
          'certificateFile',
          file.path,
        ));
      }

      http.StreamedResponse response = await request.send();
      response.stream.transform(utf8.decoder).listen((res) {
        print("here is response");
        Map<String, dynamic> responseBody = jsonDecode(res);
        // print(jsonDecode(res)['status']);
        // response=jsonDecode(res)['status'];
        if (responseBody['status'] == 'success') {
          HelperFunction.saveClientDetailsPreference(
              jsonEncode(responseBody['data']));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QrScanner()));
        } else {
          Fluttertoast.showToast(
              msg: responseBody['message'],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
      if (response.statusCode == 200) {
        print('l');
      }
    } catch (err) {
      print("error has occured");
      print(err);
      Fluttertoast.showToast(
          msg: "Server error or wrong configuration file!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Page",
      home: Scaffold(
        body: Container(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 195,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/logo.png"),
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: Text("MedicoChain",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                      ),
                    ],
                  )),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 0),
                        ),
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 140,
                              padding:
                                  const EdgeInsets.fromLTRB(12.0, 17, 12, 17),
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.blueAccent)
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 0,
                                  ),
                                  left: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                  top: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              child: Text("Continues as: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width -
                                    140 -
                                    50,
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.blueAccent)),
                                child: Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      //  decoration: InputDecoration(border: InputBorder.none),
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: <String>[
                                        'Manufacturer',
                                        'Distributor',
                                        'Wholesaler',
                                        'Retailer',
                                        'Customer'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 0),
                        ),
                        width: MediaQuery.of(context).size.width - 50,
                        child: dropdownValue != 'Customer'
                            ? Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 140,
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 17, 12, 17),
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.blueAccent)
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 0,
                                        ),
                                        left: BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                        top: BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                    child: Text("Certificate File: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  GestureDetector(
                                    onTap: chooseFile,
                                    child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                140 -
                                                50,
                                        padding: const EdgeInsets.fromLTRB(
                                            35.0, 17, 35, 17),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueAccent)),
                                        child: Center(
                                          child: Text(
                                            file != null ? file.name : "Choose",
                                            style: TextStyle(
                                                color: Colors.deepPurple),
                                          ),
                                        )),
                                  ),
                                ],
                              )
                            : SizedBox(height: 0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: RaisedButton(
                      color: Colors.lightBlue,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                          isSubmitting ? "Submitting..." : 'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: submitHandler),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonH {}
