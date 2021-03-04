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

InputDecoration calanderFormFieldDecoration(String hint, setDate, context) {
  return InputDecoration(
    suffix: InkWell(
      onTap: () {
        print("the icon is tapped");
        // setDate(context);
      },
      child: Icon(Icons.calendar_today),
    ),
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
    textAlign: TextAlign.left,
    textAlignVertical: TextAlignVertical.bottom,
    validator: (value) {
      if (value.isEmpty) {
        return "This field can\'t be empty!";
      }
      return null;
    },
    decoration: textFieldInputDecoration(hint),
    controller: controller,
    style: inputTextStyle(),
  );
}
