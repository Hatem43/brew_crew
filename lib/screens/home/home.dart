import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/screens/home/Brewlist.dart';
import 'package:brew_crew/modules/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
class Home extends StatelessWidget {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
       showModalBottomSheet(context: context, builder: (context){ // this will show a bottom sheet
         return Container(
           padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
           child:SettingsForm(), // this will show the Setting form page
         );
       });
    }
    return StreamProvider<List<Brew>>.value( // we recording the changes that happens in list of brews
      value:DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('brew crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
                onPressed: ()async{
                  await _auth.signOut(); // when this is complete, the user value will be null and return to authenticate screen
                },
                icon: Icon(Icons.person),
                label: Text('log out')
            ),
            FlatButton.icon(
                onPressed: (){
                  _showSettingsPanel();
                },
                icon: Icon(Icons.settings),
                label: Text('settings')
            ),
          ],
        ),
        body:Container(
            child: brewList(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage('https://raw.githubusercontent.com/iamshaunjp/flutter-firebase/lesson-27/brew_crew/assets/coffee_bg.png'),
                fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
