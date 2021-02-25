import 'package:flutter/material.dart';
import 'package:healthChain/constant.dart';
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
  Future<Medicine> futureMedicine;
  @override
  void initState() {
    print("initstate called");
    super.initState();
    futureMedicine = getdata();
  }

  onAddItemHandler() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MedicineDataInputForm()));
  }

  Future<Medicine> getdata() async {
    print("Entered getdata");
    http.Response response = await http.get(Uri.encodeFull(
        "http://192.168.1.6:3000/medicine?drugNumber=" + widget.scanResult));
    print("scanned");
    print(response.body);
    if (response.statusCode == 200) {
      print("positive response");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return jsonDecode(response.body)[0];
      if (response.body == "[]") {
        print("entered first condition");
        return Medicine.fromJson(
          jsonDecode("{}")
        );
      } else {
        print("entered second condition");
        return Medicine.fromJson(jsonDecode(response.body)[0]);
      }
    } else {
      print("negative response");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan result'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: FutureBuilder<Medicine>(
          future: futureMedicine,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                alignment: Alignment.topCenter,
                child: Card(
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: snapshot.data.expDate == ""
                          ? [
                              Text(
                                "DrugNumber :" + snapshot.data.drugNumber,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ]
                          : [
                              Text(
                                "DrugNumber :" + snapshot.data.drugNumber,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "manufacturer :" + snapshot.data.manufacturer,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "manufacturedIn :" + snapshot.data.manufacturedIn,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "mfgDate :" + snapshot.data.mfgDate,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "expDate :" + snapshot.data.expDate,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "dose :" + snapshot.data.dose,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "composition :" + snapshot.data.composition,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "bn :" + snapshot.data.bn,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "isSoldOut :" + snapshot.data.isSoldOut,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "mrp :" + snapshot.data.mrp,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              Text(
                "DrugNumber :" + Constants.drugNumber,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              );
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddItemHandler,
        // onPressed: null,
        child: Text("Add"),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
