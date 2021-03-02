import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
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
// http.Response response = await http.get(
//    'https://cdn.pixabay.com/photo/2020/09/23/14/38/woman-5596173_960_720.jpg',
//       );

// print(base64Encode(response.bodyBytes));

    try {
      FilePickerResult result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile selectedFile = result.files.first;
        setState(() {
          file = selectedFile;
        });
        print('here is file-------------');
        print(selectedFile);

        print(selectedFile.name);
        print(selectedFile.bytes);
        print(selectedFile.size);
        print(selectedFile.extension);
        print(selectedFile.path);

        // List<int> imageBytes = selectedFile.bytes.;
        // print(imageBytes);
        // String base64Image = base64Encode(imageBytes);
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
      request.fields['imageName'] =
          'image name here----------------------------------------------------------------------------------------------------------------------';
      request.files.add(await http.MultipartFile.fromPath(
        'certificateFile',
        file.path,
      ));
      http.StreamedResponse response = await request.send();
      response.stream.transform(utf8.decoder).listen((event) {
        print(event);
      });
      // print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print('l');
      }
      // http.Response response = await http.post(
      //   "${Constants.backendIp}/chaincode-status",
      //   headers: {"Content-type": "application/json"},
      // );

      // print("scanned");
      // print(response.body);
      // Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // print(jsonResponse['status']);
      // if (response.statusCode == 200) {
      //   print("connection established");
      //   return null;
      // } else {
      //   print("negative response");
      //   // If the server did not return a 200 OK response,
      //   // then throw an exception.
      //   throw Exception('Failed to load album');
      // }
    } catch (err) {
      print("error has occured");
      print(err);
      Fluttertoast.showToast(
          msg: "Server error or wrong configuration file!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    } finally {
      setState(() {
        isSubmitting = false;
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => QrScanner()));
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
                SizedBox(height: MediaQuery.of(context).size.height - 195),
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
                              width: 120,
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
                                width: MediaQuery.of(context).size.width -
                                    120 -
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
                                        'Supplier',
                                        'Whloesaler',
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
                        child: Row(
                          children: [
                            Container(
                              width: 120,
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
                              child: Text("Certificate File: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            GestureDetector(
                              onTap: chooseFile,
                              child: Container(
                                  width: MediaQuery.of(context).size.width -
                                      120 -
                                      50,
                                  padding: const EdgeInsets.fromLTRB(
                                      35.0, 17, 35, 17),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent)),
                                  child: Center(
                                    child: Text(
                                      file != null
                                          ? file.name.length >= 15
                                              ? file.name.substring(0, 15) +
                                                  '...'
                                              : file.name
                                          : "Choose",
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                    ),
                                  )),
                            ),
                          ],
                        ),
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