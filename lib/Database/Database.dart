import 'package:cloud_firestore/cloud_firestore.dart';
import '../Auth/User.dart';

class Database{
  final String uid;

  Database({required this.uid});

  static final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  static final CollectionReference foodCollection = FirebaseFirestore.instance.collection('Food');

  Future<bool> alreadyRegistered()async{
    return (await userCollection.doc(uid).get()).exists;
  }

  Future<void> insertUser(String email, String role){
    return userCollection.doc(uid).set({
      'email':email,
      'role':role
    });
  }

  Future<User> getUser()async{
    Map<String,dynamic> result = (await userCollection.doc(uid).get()).data() as Map<String,dynamic>;
    return User(email: result['email'],role: result['role']);
  }

}