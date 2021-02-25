import 'package:flutter/material.dart';
import 'package:healthChain/medicine_modal.dart';
import 'package:healthChain/success.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'widget.dart';

class MedicineDataInputForm extends StatefulWidget {
  @override
  _MedicineDataInputFormState createState() => _MedicineDataInputFormState();
}

class _MedicineDataInputFormState extends State<MedicineDataInputForm> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController manufacuredDateEditingController =
      new TextEditingController();
  TextEditingController manufacurerEditingController =
      new TextEditingController();
  TextEditingController manufacuredInEditingController =
      new TextEditingController();
  TextEditingController expiryDateEditingController =
      new TextEditingController();
  TextEditingController dosEditingController = new TextEditingController();
  TextEditingController compositionEditingController =
      new TextEditingController();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController batchNoEditingController = new TextEditingController();
  TextEditingController maximumRetailPriceEditingController =
      new TextEditingController();
  onSubmitHandler() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      final uri = "http://192.168.1.6:3000/medicine";
      var requestBody = {
        " manufacturer": manufacurerEditingController,
        "manufacturedIn": manufacuredInEditingController,
        "mfgDate": manufacuredDateEditingController,
        "expDate": expiryDateEditingController,
      };
      print("entering into the post");
      http.Response response = await http.post(
        uri,
        body: json.encode(requestBody),
      );
      print(response.body);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Success()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Info Input Form'),
      ),
      body: isLoading
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg_image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg_image.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color.fromRGBO(255, 255, 255, 0.85),
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(children: [
                          inputFormField(
                              "Manufacturer", manufacurerEditingController),
                          inputFormField("Manufactured In",
                              manufacuredInEditingController),
                          inputFormField(
                              "Mfg Date", manufacuredDateEditingController),
                          inputFormField(
                              "Exp Date", expiryDateEditingController),
                          inputFormField("Dose", dosEditingController),
                          inputFormField(
                              "Composition", compositionEditingController),
                          inputFormField("Name", nameEditingController),
                          inputFormField("Batch No", batchNoEditingController),
                          inputFormField(
                              "MRP", maximumRetailPriceEditingController),
                        ]),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          onSubmitHandler();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC),
                              ]),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Text(
                            "Submit",
                            // style: mediumInputTextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
