import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tracktoeat/Database/Database.dart';

import '../Globals.dart';
import 'AuthUser.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<void> reloadUser()async{
    return await _auth.currentUser?.reload();
  }

  // Login with Google
  Future<AuthUser> loginWithGoogle()async{

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if(googleUser == null) {
        throw "GoogleUser is Null!";
      }

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      UserCredential result = await _auth.signInWithCredential(credentials);


      if(result.user==null){
        throw "User is Null";
      }

      User _user = result.user!;
      String role = primaryUser;
      String _uid = _user.uid;
      bool alreadyRegistered = await Database.alreadyRegistered(_user.email??"");
      if(alreadyRegistered) {
        print('Already Registered User!');
        role = (await Database.getUser(_user.email??"")).role;
      }
      else {
        if(_user.email==null){
          throw "Email is Null!";
        }

        if(!_user.email!.endsWith("nitc.ac.in")){
          throw "Only NITC users allowed!";
        }

        Database(uid: _uid).insertUser(_user.email!, role);
      }
      return AuthUser(user:_user,role:role,error:"");
    }catch(e){
      return AuthUser(user:null,role:"",error:e.toString());
    }
  }

  // Logout
  Future<void> logout()async {
    await _auth.signOut();
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.disconnect();
  }
}