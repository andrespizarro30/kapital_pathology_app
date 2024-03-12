import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapital_pathology_app/components/buttons.dart';
import 'package:kapital_pathology_app/components/common_functions.dart';
import 'package:kapital_pathology_app/components/square_tile.dart';
import 'package:kapital_pathology_app/components/textfields.dart';
import 'package:kapital_pathology_app/models/UsersModel.dart';
import 'package:kapital_pathology_app/providers/server_data_provider.dart';

import '../components/progress_dialog.dart';
import '../services/auth_services.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                //logo
                SquareTile(imagePath: 'lib/images/kapital_logo.jpg',height: 100,),
              const SizedBox(height: 50),
                //welcome back. you been missed
                Text("Constructora Kapital",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 30
                  ),
                ),
                Text("App Patología de la Construcción",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18
                  ),
                ),
                const SizedBox(height: 25),
                // username textfield
                UserTextField(
                  controller: userNameController,
                  hintText: "Nombre de usuario",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //password textfield
                UserTextField(
                  controller: passwordController,
                  hintText: "Contraseña",
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                //sign in button
                LogInButton(
                  onTap: userLogInWithEmailPwdFB,
                ),
                const SizedBox(height: 25),
                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("O Inicie sesión con...",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                //google
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        child: SquareTile(imagePath: 'lib/images/google_logo.png',height: 40),
                        onTap: () async{
                          var resp = await AuthGoogleService().signInWithGoogle();

                          if(resp.user != null){
                            displayToastMessages("Bienvenido!!!", context);
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(context, "main_menu", (route) => false);
                          }else{
                            displayToastMessages("Usuario y/o clave incorrectos!!!", context);
                            Navigator.pop(context);
                          }

                        },
                    )
                  ],
                )
                //not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }

  void userLogInWithEmailPwdFB() async{
    String email = userNameController.text;
    String pwd = passwordController.text;
    final User? firebaseUser = (await FirebaseAuth
        .instance
        .signInWithEmailAndPassword(email: email, password: pwd
    ).catchError((onError){
      displayToastMessages("Error ${onError.toString()}", context);
    })).user;

    if(firebaseUser != null){
      displayToastMessages("Bienvenido!!!", context);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, "main_menu", (route) => false);
    }else{
      displayToastMessages("Usuario y/o clave incorrectos!!!", context);
      Navigator.pop(context);
    }
  }

  void userLogInWithOwnAPI() async{

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) => ProgressDialog(
            message: "Por favor espere..."
        )
    );

    ServerDataProvider serverDataProvider = ServerDataProvider();

    String user = userNameController.text;
    String pwd = passwordController.text;

    var response = await serverDataProvider.usersLogin(user, pwd);

    if(response.usuarios == user && response.clave == pwd){
      displayToastMessages("Bienvenido!!!", context);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, "main_menu", (route) => false);
    }else{
      displayToastMessages("Usuario y/o clave incorrectos!!!", context);
      Navigator.pop(context);
    }

  }

}
