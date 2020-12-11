import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Details extends StatefulWidget {
  final String scanResult;
  Details(this.scanResult);
  @override
  _DetailsState createState() => _DetailsState();
  
}

class _DetailsState extends State<Details> {
   getdata()async{
     print("Entered getdata");
   http.Response response= await http.get(
     Uri.encodeFull("http://192.168.100.17:3000/medicine?drugNumber="+widget.scanResult)
   );
   print("scanned");
   print(response.body);
  }
   void initState(){
     print("initstate called");
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan result'),
      ),
      body: Center(
        child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children:<Widget>[
             Card(
               child:Text(widget.scanResult),
             )

           ],
        )
      ),
      
    );
  }
}