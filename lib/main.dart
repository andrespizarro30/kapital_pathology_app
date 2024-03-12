import 'package:flutter/material.dart';
import 'package:kapital_pathology_app/pages/LoginPage.dart';
import 'package:kapital_pathology_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'data_handler/app_data.dart';

import 'package:firebase_core/firebase_core.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp(
      child: ChangeNotifierProvider(
        create: (context) => AppData(),
        child: MaterialApp(
          title: 'Kapital App Pathology',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: 'login',
          routes: getRoutes(),
          debugShowCheckedModeBanner: false,
        ),
      )
  ));
}

class MyApp extends StatefulWidget {

  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context){
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Key key = UniqueKey();

  void restartApp(){
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {

    requestPermissions();

    return KeyedSubtree(
        key: key,
        child: widget.child!
    );
  }

  void requestPermissions(){
    //requestPositionPermission();
    //requestStoragePermission2();
  }

}