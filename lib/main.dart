import 'package:brew_crew/modules/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/auth.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home:Wrapper(), //  inside wrapper we can listen to auth changes if user signed in ,we will get that user ,if not it will return null
      ),
    );
  }
}
