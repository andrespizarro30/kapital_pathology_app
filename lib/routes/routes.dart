import 'package:flutter/material.dart';

import '../pages/LoginPage.dart';
import '../pages/MainMenuPage.dart';


Map<String, WidgetBuilder> getRoutes(){
  return <String,WidgetBuilder>{
    'login' : (BuildContext context) => LoginPage(),
    'main_menu' : (BuildContext context) => MainMenuPage(),
  };
}