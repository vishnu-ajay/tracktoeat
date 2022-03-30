import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Auth/Auth.dart';
import '../Globals.dart';
import '../Theme.dart';
import 'Loading.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  const Login({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  int page = 0;
  String email = "";
  String password = "";
  bool loading = false;
  bool showLoading = false;
  String error = "";
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    if (_height < 600) _height = 600;
    double _width = MediaQuery.of(context).size.width;
    return loading
        ? WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(key: scaffoldKey, body: Loading()))
        : SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: lightTheme.value
              ? LightTheme.starWhite
              : DarkTheme.darkGray,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: _height,
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      SizedBox(
                        height: _height / 4,
                        width: _width,
                        child: SvgPicture.asset(
                          'assets/undraw_authentication_fsn5.svg',
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Login with NITC mail',
                              style: TextStyle(
                                  color: lightTheme.value
                                      ? Colors.grey
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Montserrat",
                                  fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary:lightTheme.value?LightTheme.starWhite:DarkTheme.darkGray),
                        onPressed: ()async {
                          setState(() {
                            showLoading = true;
                          });
                          var res = await _auth.loginWithGoogle();
                          setState(() {
                            showLoading  = false;
                          });
                        },
                        child: Container(
                            width: 200,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            child: Image(
                              image:
                              Image.asset('assets/google.png').image,
                            )),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
              if (showLoading)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              if (showLoading)
                const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          LightTheme.caribbeanGreen),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),);
  }
}