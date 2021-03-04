import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthChain/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrugHistory extends StatefulWidget {
  final String scanResult;
  DrugHistory(this.scanResult);
  @override
  _DrugHistoryState createState() => _DrugHistoryState();
}

class _DrugHistoryState extends State<DrugHistory> {
  bool isLoading = true;
  Map<String, dynamic> drugHistory = {};
  @override
  void initState() {
    print("initstate called");
    super.initState();
    getDrugHistory();
  }

  getDrugHistory() async {
    print("Entered getdata");
    try {
      http.Response response = await http.post(
          "${Constants.backendIp}/drug-history",
          headers: {"Content-type": "application/json"},
          body: widget.scanResult);
      setState(() {
        isLoading = false;
      });

      print("Here is response body in history");
      print(response.body);
      Map jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);
      if (response.statusCode == 200) {
        if (jsonResponse['status'] == 'success') {
          setState(() {
            drugHistory = jsonResponse["history"];
          });
        } else {
          // return (jsonResponse["state"]);
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
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => QrScanner()));

    }
  }

  @override
  Widget build(BuildContext context) {
    print('here is history inside build');
    // print(drugHistory);

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    print('height and wdith is ');
    print(h);
    print(w);

    var myArr = [];

    drugHistory.forEach((key, value) {
      // print('here is vlaue----------');
      // print(value);
      try {
        if (value['data'] != null) myArr.add(value);
      } catch (e) {
        print(e);
      }
      // if (value['timestamp'] != null && value['data'] != null) {
      // }
    });
    // print(myArr);

    myArr.forEach((element) {
      print('here is data-----------------------------------------------------------------------------');
      print(jsonDecode(element['data']));
     });

    // for(var i = 0;i<myArr.length;i++){
    //   print(jsonDecode(myArr[i]['data']));
    // }

    // print(jsonDecode(myArr[0]['data'])['owner']);
    // var myArr = [
    //   'Manufacturer',
    //   'Distributor',
    //   'Wholesaler',
    //   'Retailer',
    //   'Consumer'
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Drug History'),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   // image: DecorationImage(
        //   //   image: AssetImage("assets/bg_image.jpg"),
        //   //   fit: BoxFit.cover,
        //   // ),
        // ),
        child: Center(child: FutureBuilder<dynamic>(
          // future: futureMedicine,
          builder: (context, snapshot) {
            if (!isLoading) {
              return SingleChildScrollView(
                child: Container(
                    width: w,
                    // height: h,
                    decoration: BoxDecoration(
                        // color: Colors.green[200],
                        ),
                    child: Row(
                      children: [
                        //left container
                        Container(
                            width: w / 5,
                            // height: h,
                            decoration: BoxDecoration(
                                // color: Colors.red[100],

                                ),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 0,
                                  ),
                                  ...myArr.map((value) {
                                    return Column(children: [
                                      Center(
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      myArr.indexOf(value) != myArr.length - 1
                                          ? Center(
                                              child: Container(
                                                height: 175,
                                                width: 4,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  // borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 0,
                                            ),
                                      myArr.indexOf(value) != myArr.length - 1
                                          ? SizedBox(
                                              height: 5,
                                            )
                                          : SizedBox(
                                              height: 0,
                                            )
                                    ]);
                                  }),
                                ],
                              ),
                            )),

                        //right containger
                        Container(
                            // alignment: Alignment.topCenter,
                            width: 4 * w / 5,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            decoration: BoxDecoration(
                                // color: Colors.blue[100],
                                ),
                            child: Column(
                              children: [
                                ...myArr.map((value) {
                                  return Container(
                                    width: 4 * w / 5,
                                    height: 200,
                                    child: Card(
                                      margin: EdgeInsets.fromLTRB(0, 20, 30, 0),
                                      child: Text(jsonDecode(value['data'])['owner']),
                                    ),
                                  );
                                }).toList(),
                              ],
                            )),
                      ],
                    )),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }
}
