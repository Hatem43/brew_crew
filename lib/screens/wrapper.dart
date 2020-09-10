import 'package:brew_crew/modules/user.dart';
import 'package:brew_crew/screens/authenticate/authentication.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context); // this will access the User data from the provider every time we get new value
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
