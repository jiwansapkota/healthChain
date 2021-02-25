import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.black45,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlue),
    ),
  );
}

TextStyle inputTextStyle() {
  return TextStyle(
    color: Colors.black87,
    fontSize: 16,
  );
}

TextFormField inputFormField(String hint, TextEditingController controller) {
  return TextFormField(
    textAlign: TextAlign.center,
    textAlignVertical: TextAlignVertical.bottom,
    validator: null,
    decoration: textFieldInputDecoration(hint),
    controller: controller,
    style: inputTextStyle(),
  );
}
