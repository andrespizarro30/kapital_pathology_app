import 'package:flutter/material.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("Constructora Kapital"),
        ),
        drawer: Container(
          color: Colors.white,
          width: 300.0,
          child: Drawer(
            child: ListView(
              children: [
                Container(
                  height: 165.0,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Image.asset("lib/images/kapital_logo.jpg",height: 65.0,width: 65.0,),
                  ),
                ),
                Divider(
                  height: 1.0,
                  color: Colors.black,
                  thickness: 1.0,
                ),
                SizedBox(height: 12.0,),
                ListTile(
                  leading: Icon(Icons.house),
                  title: Text("Patología Construcción",style: TextStyle(fontSize: 15.0)),
                  onTap: (){

                  },
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
