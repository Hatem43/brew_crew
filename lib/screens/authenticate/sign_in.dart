import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/modules/user.dart';
import 'package:brew_crew/shared/constants.dart';
class Sign_In extends StatefulWidget {
  final Function toggleview; // to be able to pass this function in the sign_in.dart
  Sign_In({this.toggleview});
  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  final AuthService _auth=AuthService();
  final _formkey=GlobalKey<FormState>();
  bool loading =false;
  //textField state
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return loading? Loading() :Scaffold( // if loading is true it will return Loading widget if not it will return Sign in
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('sign in'),
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleview(); // this will refer to the Sign_in widget return register page
              },
              icon:Icon(Icons.person),
              label: Text('Register'),),
        ],
      ),
      body: Container(
        height: double.infinity,
        color: Colors.pinkAccent,
        padding: EdgeInsets.symmetric(vertical:20 ,horizontal:50 ),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration:BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
                    ),
                  ) ,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText:'Email'),
                  validator: (val)=>val.isEmpty?'Enter email':null,
                  onChanged: (val){ //  show what will happen when user start typing
                   setState(() {
                     email=val;
                   });
                  },
                ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText:'Password'),
                    obscureText: true,
                    validator: (val)=>val.length<6? 'Enter password 6+ chars long':null,
                    onChanged: (val){ //  show what will happen when user start typing
                     setState(() {
                       password=val;
                     });
                    },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.black,
                  child: Text('Sign in',style: TextStyle(color: Colors.white),),
                  onPressed: ()async {
                    if (_formkey.currentState.validate()) { // this will validate our form based on the key state
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signinwithemailandpassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Could not sign in';
                          loading = false;
                        });
                      }
                    }
                  }
    ),
                SizedBox(height: 12),
                Text(error,
                  style: TextStyle(color: Colors.red,fontSize: 14),),
              ],
            ),
          ),
        )
      ),
    );
  }
}
