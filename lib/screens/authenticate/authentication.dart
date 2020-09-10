import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSign_in=true; // this is the first value for showSign_in will be when we start the app

void toggleview(){ // to be able to change from Sign_in form to register form and vise versa
  setState(() {
    showSign_in=!showSign_in;
  });
}
  @override
  Widget build(BuildContext context) {
   if(showSign_in){
     return Sign_In(toggleview:toggleview); // this will return Sign_in and also change showSign_in value after going to sign in page
   }
   else{
     return Register(toggleview:toggleview);// this will refer to the Register and also change the showSign_in value
   }
  }
}
