import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthChain/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HelperFunction{
static String sharedPreferenceClientDetails="clientDetails";

static Future<bool> saveClientDetailsPreference(String clientDetails) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceClientDetails, clientDetails);

  }
   static Future<String> getClientDetailsPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceClientDetails);
  }

  // onLogout()async{
  // SharedPreferences  prefs=await SharedPreferences.getInstance();
  //   await prefs.setString(sharedPreferenceClientDetails, "");

  // }


}
