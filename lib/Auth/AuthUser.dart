import 'package:firebase_auth/firebase_auth.dart';

class AuthUser{
  final User? user;
  String role,error;
  AuthUser({required this.user,required this.role,required this.error});
}