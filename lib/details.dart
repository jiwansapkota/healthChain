import 'package:flutter/material.dart';
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

  Future<Medicine> getdata() async {
    print("Entered getdata");
    http.Response response = await http.get(Uri.encodeFull(
        "http://192.168.100.5:3000/medicine?drugNumber=" + widget.scanResult));
    print("scanned");
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return jsonDecode(response.body)[0];
      return Medicine.fromJson(jsonDecode(response.body)[0]);
    } else {
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
      body: Center(
          child: FutureBuilder<Medicine>(
        future: futureMedicine,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              alignment: Alignment.topCenter,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data.drugNumber == null
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
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      )),
    );
  }
}
