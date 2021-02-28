import 'package:flutter/material.dart';
import 'package:healthChain/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthChain/manuform.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'medicine_modal.dart';

class Details extends StatefulWidget {
  final String scanResult;
  Details(this.scanResult);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isLoading = true;
  bool isManufactured = false;
  Future<dynamic> futureMedicine;
  @override
  void initState() {
    print("initstate called");
    super.initState();
    futureMedicine = getdata();
  }

  onAddItemHandler() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MedicineDataInputForm(widget.scanResult)));
  }
  // Future<Medicine> getMoreDetail()async{
  //   http.Response response = await http.get(Uri.encodeFull(
  //       "http://192.168.1.6:3000/medicine?drugNumber=" + widget.scanResult));
  //       print(response.body);

  // }

  Future<dynamic> getdata() async {
    print("Entered getdata");
    try {
      http.Response response = await http.post(
          "${Constants.backendIp}/drug-state",
          headers: {"Content-type": "application/json"},
          body: widget.scanResult);
      setState(() {
        isLoading = false;
      });

      print("scanned");
      print(response.body);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (response.statusCode == 200) {
        if (jsonResponse['state']['currentState'] == null) {
          print("drug not found");
          // Fluttertoast.showToast(
          //     msg: "Drug not manufactured!!",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM_RIGHT,
          //     timeInSecForIosWeb: 10,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          return null;
        } else {
          setState(() {
            isManufactured = true;
          });
          print("drug found");
          return (jsonResponse["state"]);
        }
      } else {
        print("negative response");
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "Cannot connect to server",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
  }

  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var containerHeight = queryData.size.height - 200;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan result'),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   // image: DecorationImage(
        //   //   image: AssetImage("assets/bg_image.jpg"),
        //   //   fit: BoxFit.cover,
        //   // ),
        // ),
        child: Center(
            child: FutureBuilder<dynamic>(
          future: futureMedicine,
          builder: (context, snapshot) {
            if (!isLoading) {
              return Column(children: [
                SingleChildScrollView(
                  child: Container(
                      height: containerHeight,
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                          // color: Colors.green,
                          ),
                      child: snapshot.hasData
                          ? Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  SingleChildScrollView(
                                    child: Card(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 16.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "DrugNumber :" +
                                                  snapshot.data["drugNumber"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              "manufacturer :" +
                                                  snapshot.data["manufacturer"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              "manufacturedIn :" +
                                                  snapshot
                                                      .data["manufacturedIn"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              "mfgDate :" +
                                                  snapshot.data["mfgDate"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              "expDate :" +
                                                  snapshot.data["expDate"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              "dose :" + snapshot.data["dose"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              "composition :" +
                                                  snapshot.data["composition"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              "bn :" + snapshot.data["bn"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            Text(
                                              "mrp :" + snapshot.data["mrp"],
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    color: Colors.lightBlue,
                                    child: Text(
                                      'More',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: null,
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                              padding: EdgeInsets.fromLTRB(0,
                                  MediaQuery.of(context).size.height / 3, 0, 0),
                              child: Text(
                                "Drug not manufactured!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // backgroundColor: Colors.red,
                                ),
                              ),
                            ))),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                      child: Text(
                        'See Drug History',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: onAddItemHandler,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                      child: Text(
                        'Manufacture Drug',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: onAddItemHandler,
                  ),
                ),
              ]);
            } else {
              return CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }
}
