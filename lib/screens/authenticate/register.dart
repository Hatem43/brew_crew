import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
class Register extends StatefulWidget {
  final Function toggleview; // to be able to pass this function in the register.dart
  Register({this.toggleview});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formkey=GlobalKey<FormState>();
  bool loading=false;
  //textField state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('sign up  to brew crew'),
          actions: [
          FlatButton.icon(
          onPressed: (){
            widget.toggleview(); // this will refer to the Register widget and return sign in page
    },
      icon:Icon(Icons.person),
      label: Text('Sign_in'),),
          ],
      ),
      body: Container(
          height: double.infinity,
          color: Colors.pinkAccent,
          padding: EdgeInsets.symmetric(vertical:20 ,horizontal:50 ),
          child: Form(
            key: _formkey,//this will associate this _formkey(global key) with our form used as validator
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
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                   validator: (val) => val.isEmpty? 'Enter an email' : null,
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
                      validator: (val) => val.length < 6? 'Enter password 6+ chars long': null,
                    onChanged: (val){ //  show what will happen when user start typing
                      setState(() {
                        password=val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                      color: Colors.black,
                    child: Text('Register',style: TextStyle(color: Colors.white),),
                    onPressed: ()async{
                      if(_formkey.currentState.validate())// this will validate our form based on the key state
                        {
                          setState(() {
                            loading=true;
                          });
                          dynamic result=await _auth.registerwithemailandpassword(email, password);
                          if(result==null){
                         setState(() {
                           error='please supply valid email';
                           loading=false;
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
          ),
      ),
    );
  }
}
