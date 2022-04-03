import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tracktoeat/Globals.dart';
import '../Auth/User.dart';
import 'Food.dart';

class Database{
  final String uid;

  Database({required this.uid});

  static final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  static final CollectionReference foodCollection = FirebaseFirestore.instance.collection('Food');
  static final CollectionReference messCollection = FirebaseFirestore.instance.collection('Mess');
  static final CollectionReference messRepMappingCollection = FirebaseFirestore.instance.collection('MessRepMapping');
  static Future<bool> alreadyRegistered(String email)async{
    return ((await userCollection.where('email',isEqualTo: email).get()).docs.isNotEmpty);
  }

  Future<void> insertUser(String email, String role){
    return userCollection.doc(uid).set({
      'email':email,
      'role':role
    });
  }

  static Future<String> getUserRole(String email)async{
    Map<String, dynamic> result = (await userCollection.where('email',isEqualTo: email).get()).docs.first.data() as Map<String, dynamic>;
    return result['role'];
  }

  static Future<User> getUser(String email)async {
    Map<String, dynamic> result = (await userCollection.where('email',isEqualTo: email).get()).docs.first.data() as Map<String, dynamic>;
    return User(email: result['email'], role: result['role']);
  }
  
  static Future<Food> getFood(String mess,String day, String mealType)async{
    List<QueryDocumentSnapshot<Object?>> snapshotDocs = (await foodCollection.where('day',isEqualTo: day).where('mess', isEqualTo: mess).where('mealType',isEqualTo: mealType).get()).docs;
    if(snapshotDocs.isEmpty){
      return Food.fromJson({});
    }
    var result = snapshotDocs.first.data() as Map<String, dynamic>;
    return Food.fromJson(result);
  }
  
  static Future<void> setFood(Food data)async{
    Map<String,dynamic>food = data.toJson();

    List<QueryDocumentSnapshot> _list = (await foodCollection.where('day',isEqualTo: data.day).where('mess', isEqualTo: data.mess).where('mealType',isEqualTo: data.mealType).get()).docs;
    if(_list.isNotEmpty){
      await foodCollection.doc(_list.first.id).update(food);
    }else{
      await foodCollection.add(food);
    }
  }

  static Future<String> uploadImage(Uint8List fileBytes, String fileType)async{
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance.ref().child('images/${DateTime.now().microsecondsSinceEpoch}.$fileType').putData(fileBytes);
      return snapshot.ref.getDownloadURL();
    }catch(e){
      print(e.toString());
    }

    return "-1";
  }

  static Future<List<User>> getMessRep()async{
    List<QueryDocumentSnapshot> _list = (await userCollection.where('role', isEqualTo: messRep).get()).docs;
    List<User>result = [];

    for(var l in _list){
      result.add(User(email: l['email'],role: l['role']));
    }

    return result;
  }

  static Future<List<String>> getAllMess()async{
    Map<String,dynamic> result = (await messCollection.doc('all-mess').get()).data() as Map<String,dynamic>;
    List<String>_list = [];

    if(result['mess'] == null){
      return _list;
    }

    for(String s in result['mess']){
      _list.add(s);
    }

    return _list;
  }

  static Future<List<Food>> getAllFood()async{
    List<Food>_list = [];

    List<QueryDocumentSnapshot>_snapshots = (await foodCollection.get()).docs;

    for(var snapshot in _snapshots){
      _list.add(Food.fromJson(snapshot.data() as Map<String,dynamic>));
    }

    return _list;
  }

  static Future<String> getMyMess(String email)async{
    DocumentSnapshot documentSnapshot = (await messRepMappingCollection.doc(email).get());
    if(documentSnapshot.data()==null){
      return "";
    }

    Map<String,dynamic> result = documentSnapshot.data() as Map<String,dynamic>;

    return result['mess']??"";
  }


}