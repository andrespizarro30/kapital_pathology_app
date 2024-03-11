import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

displayToastMessages(String msg,BuildContext context){
  Fluttertoast.showToast(msg: msg,toastLength: Toast.LENGTH_LONG);
}

Future<bool> testInternetConnection() async {

  try{
    final result = await InternetAddress.lookup("www.google.com");
    if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
      return true;
    }
  }on SocketException catch(_){
    return false;
  }

  return false;

}