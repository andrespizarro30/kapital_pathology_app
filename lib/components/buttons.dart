import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {

  final Function()? onTap;

  const LogInButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Color(int.parse("#FBB426".substring(1, 7), radix: 16) + 0xFF000000),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text("Ingresar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          )
        ),
      ),
    );
  }
}
