import 'package:flutter/material.dart';

class MedicineDataInputForm extends StatefulWidget {
  @override
  _MedicineDataInputFormState createState() => _MedicineDataInputFormState();
}

class _MedicineDataInputFormState extends State<MedicineDataInputForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Form Details"),
      ),
      body:  Center(
        child: Column(
          children:<Widget>[
            TextField(),

          ]
        ),
      ),      
    );
  }
}