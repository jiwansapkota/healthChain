import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthChain/constant.dart';
import 'package:healthChain/medicine_modal.dart';
import 'package:healthChain/success.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'widget.dart';

class MedicineDataInputForm extends StatefulWidget {
  final String scanResult;
  MedicineDataInputForm(this.scanResult);
  @override
  _MedicineDataInputFormState createState() => _MedicineDataInputFormState();
}

class _MedicineDataInputFormState extends State<MedicineDataInputForm> {
  bool isLoading = false;
  bool isSubmitting = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController manufacuredDateEditingController =
      // new TextEditingController(text: "2020-10-01");
      new TextEditingController();
  TextEditingController manufacurerEditingController =
      // new TextEditingController(text: "Beijing Pharma");
            new TextEditingController();

  TextEditingController manufacuredInEditingController =
      // new TextEditingController(text: "China");
            new TextEditingController();

  TextEditingController expiryDateEditingController =
      // new TextEditingController(text: "2021-10-01");
            new TextEditingController();

  TextEditingController dosEditingController =
      // new TextEditingController(text: "100mg");
            new TextEditingController();

  TextEditingController compositionEditingController =
      // new TextEditingController(text: "acetone-50mg,acetic acid-40mg");
            new TextEditingController();

  TextEditingController nameEditingController =
      // new TextEditingController(text: "Aspirin");
            new TextEditingController();

  TextEditingController batchNoEditingController =
      // new TextEditingController(text: "56/56");
            new TextEditingController();

  TextEditingController maximumRetailPriceEditingController =
      // new TextEditingController(text: "55");
            new TextEditingController();

  onSubmitHandler() async {
    print('--------mrp is: ');
    print(maximumRetailPriceEditingController.text);

    if (formKey.currentState.validate()) {
      setState(() {
        // isLoading = true;
      });
      final uri = "${Constants.backendIp}/manufacture-drug";
      var requestBody = {
        "manufacturer": jsonDecode(widget.scanResult)["manufacturer"],
        "manufacturedIn": manufacuredInEditingController.text,
        "drugNumber": jsonDecode(widget.scanResult)["drugNumber"],
        "mfgDate": manufacuredDateEditingController.text,
        "expDate": expiryDateEditingController.text,
        "dose": dosEditingController.text,
        "composition": compositionEditingController.text,
        "name": nameEditingController.text,
        "bn": batchNoEditingController.text,
        "mrp": maximumRetailPriceEditingController.text,
      };
      print(requestBody);
      print("entering into the post");
      try {
        setState(() {
          isSubmitting = true;
        });
        http.Response response = await http.post(
          uri,
          headers: {"Content-type": "application/json"},
          body: json.encode(requestBody),
        );
        print("finished calling api");
        print(response.body);

        Fluttertoast.showToast(
            msg: "Drug successfully added!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } catch (e) {
        print("got exception");
        print(e);
      } finally {
        setState(() {
          isSubmitting = false;
        });
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Success()));
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
                  color: Color.fromRGBO(255, 255, 255, 0.95),
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(children: [
                          inputFormField("Name of Manufacturer",
                              manufacurerEditingController),
                          inputFormField("Place of Manufacture",
                              manufacuredInEditingController),
                          inputFormField("Name of Drug", nameEditingController),
                          inputFormField("Manufactured Date",
                              manufacuredDateEditingController),
                          inputFormField(
                              "Expiry Date", expiryDateEditingController),
                          inputFormField("Dose", dosEditingController),
                          inputFormField(
                              "Composition", compositionEditingController),
                          inputFormField("Batch No", batchNoEditingController),
                          inputFormField("Maximum Retail Price",
                              maximumRetailPriceEditingController),
                        ]),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            color: Colors.lightBlue,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: Text(
                                isSubmitting ? "Submitting..." : 'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: onSubmitHandler,
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
