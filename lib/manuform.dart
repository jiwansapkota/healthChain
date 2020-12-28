import 'package:flutter/material.dart';
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
  onSubmitHandler() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
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
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
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
                          // signMeIn();
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
