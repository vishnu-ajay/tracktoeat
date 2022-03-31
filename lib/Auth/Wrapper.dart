import 'package:flutter/material.dart';
import 'Auth.dart';


import 'AuthUser.dart';
import 'package:tracktoeat/Screens/Home.dart';
import 'package:tracktoeat/Screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatefulWidget {
  static String id = 'Wrapper';

  const Wrapper({Key? key}) : super(key: key);
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool hasAccount = true;

  void toggleView(){
    setState(() => hasAccount = !hasAccount);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (context, user){
        if(user.hasData) {
          return Home(authUser: AuthUser(user:user.data as User,role:"",error:""));
        }
        else {
            return Login(toggleView: toggleView);
        }
      },
    );
  }
}