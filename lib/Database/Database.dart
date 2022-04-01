import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<User> getUser()async {
    Map<String, dynamic> result = (await userCollection.doc(uid).get())
        .data() as Map<String, dynamic>;
    return User(email: result['email'], role: result['role']);
  }

  static Future<String> uploadImage(Uint8List fileBytes, String fileType)async{
    try {
      print(FirebaseStorage.instance.ref().child('images/${DateTime.now().microsecondsSinceEpoch}.$fileType').fullPath);
      print('^'*50);
      TaskSnapshot snapshot = await FirebaseStorage.instance.ref().child('images/${DateTime.now().microsecondsSinceEpoch}.$fileType').putData(fileBytes);
      return snapshot.ref.getDownloadURL();
    }catch(e){
      print(e.toString());
      print('*'*50);
    }

    return "-1";
  }

}