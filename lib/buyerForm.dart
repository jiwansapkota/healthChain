import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:MedicoChain/constant.dart';
import 'package:MedicoChain/helperFunction.dart';
import 'package:MedicoChain/qrScanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widget.dart';

class BuyerDataInputForm extends StatefulWidget {
  Map<String, dynamic> drugDetails;
  BuyerDataInputForm(this.drugDetails);
  @override
  _BuyerDataInputFormState createState() => _BuyerDataInputFormState();
}

class _BuyerDataInputFormState extends State<BuyerDataInputForm> {
  String clientDetails = "";
  bool isLoading = false;
  bool isSubmitting = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController purchaseDateTimeController =
      // new TextEditingController(text: "2020-10-05");
            new TextEditingController();

  TextEditingController newOwnerController =
      // new TextEditingController(text: "Nepal Pharma");
            new TextEditingController();

  TextEditingController purchasePlaceController =
      // new TextEditingController(text: "Beijing");
            new TextEditingController();

  TextEditingController boughtAtController =
      // new TextEditingController(text: "45");
            new TextEditingController();

  void initState() {
    print("initstate called");
    super.initState();
    print(HelperFunction.getClientDetailsPreference());
    getClientDetails() async {
      print('here is the details of orgatinationas');
      String receivedDetails =
          await HelperFunction.getClientDetailsPreference();
      print(receivedDetails);
      setState(() {
        clientDetails = receivedDetails;
      });
    }
    getClientDetails();
  }

  onPurchaseHandler() async {
    print('--------mrp is: ');
    print(boughtAtController.text);

    if (formKey.currentState.validate()) {
      
      setState(() {
        // isLoading = true;
      });
      final uri = "${Constants.backendIp}/${jsonDecode(clientDetails)["organization"] =='customer'?'retail-drug':'transfer-drug'}";
      print("this is received drug detaisl------------------");
      print(widget.drugDetails);
      var requestBody = {
        "manufacturer": widget.drugDetails["manufacturer"],
        "drugNumber": widget.drugDetails["drugNumber"],
        "currentOwner": widget.drugDetails["owner"],
        "newOwner": newOwnerController.text,
        "boughtAt": boughtAtController.text,
        "purchaseDateTime": purchaseDateTimeController.text,
        "purchasePlace": purchasePlaceController.text,
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
            msg: "Drug successfully purchased!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QrScanner()));
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
        title: Text('Buy Drug'),
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
                          inputFormField("Name of Buyer", newOwnerController),
                          inputFormField(
                              "Place of Purchase", purchasePlaceController),
                          inputFormField(
                              "Date of Purchase", purchaseDateTimeController),
                          inputFormField("Purchase Price", boughtAtController),
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
                            onPressed: onPurchaseHandler,
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
