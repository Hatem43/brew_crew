import 'package:brew_crew/modules/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/modules/brew.dart';
import 'package:brew_crew/modules/user.dart';
class DatabaseService {
  // this will contain all services we need from database
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews'); // this will create collection called brews

  Future updateUserData(String sugars, String name, int strength) async {
    //this will update the user data by using the uid once  a new user register successfully
    return await brewCollection.document(uid).setData({ // this will set data of document with the uid we passed
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }
  //brew list from snapshot
  List<Brew>_brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) { // this will map the list of documents we get from snapshot
      //each one will return single brew
       return Brew(
           name: doc.data['name'] ?? '', // if it doesn't have a name it will give empty string
         strength:doc.data['strength'] ?? 0,// if it doesn't have a name it will give 0
         sugars: doc.data['sugars'] ?? '0',// if it doesn't have a name it will give '0'
       );
    }).toList();
  }
  //userdata from snapshots

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){ //this will return user data based on data we get from snapshot of documents
     return UserData(
       uid:uid,
       name:snapshot.data['name'],
       sugars:snapshot.data['sugars'],
       strength:snapshot.data['strength'],
     );
  }

  //get brews stream
   Stream <List<Brew>> get brews{ // this will return list of brews
    return brewCollection.snapshots() // this will take snapshots from the created collection and map it into list of brews
     .map(_brewListFromSnapshot);
   }
   //get user data doc

Stream<UserData> get userData{ // this will take the snapshots we get from documents and put it in userdata model
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}
}