import 'package:brew_crew/modules/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey=GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4']; // this will be the values we use from dropdown to choose how many sugars we need

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context); // this will give us access to user
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder:(context,snapshot) {
        if(snapshot.hasData){  //this will check that snapshot has data
         UserData userData =snapshot.data; //this will make object from UserData and wil equal to the snapshot data[new crew member,0,100]
            return Form(
              key: _formkey,
              child: Column(
                children: [
                  Text('update your brew settings', style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue:userData.name,//initialvalue=new crewmember
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (val) => val.isEmpty ? 'please enter name' : null,
                    onChanged: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  //drop down
                  DropdownButtonFormField( //this will show data in drop down menu
                      decoration: textInputDecoration,
                      value: _currentSugars ?? userData.sugars,
                      //this will make the initial value of dropdown will equal to the initial value of _currentstate
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar, // this will take the intial value and increase by one each  scroll down
                          child: Text('$sugar suagrs'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentSugars = val; // this will update the value of _currentsugars to the value we choose
                        });
                      }
                  ),
                  //slider
                  Slider( //this will slide the widget from left to right
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    // this will check the initial value if it's equal to _currentSrength or to the userData.strength and convert to double
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    //this s the start value
                    max: 900.0,
                    //this is the end value
                    divisions: 8,
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round(); //this will convert the val to integer
                      });
                    },
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Update', style: TextStyle(color: Colors.white),),
                    onPressed: () async { // because we will update these values by communicating with db
                      if(_formkey.currentState.validate()){
                        await DatabaseService(uid:user.uid).updateUserData( //this will send the data to database and update these values
                        _currentSugars??userData.sugars, //this will check if the _currentSuagrs has value if not it will forback to first value
                          _currentName??userData.name,//this will check if the _currentName has value if not it will forback to first value
                          _currentStrength??userData.strength,//this will check if the _currentStrength has value if not it will forback to first value
                        );
                        Navigator.pop(context); //this will close the bottom  sheet
                      }
                    },
                  ),
                ],
              ),
            );
        }
        else{
         return Loading();
        }
      }
    );
  }
}
