import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tracktoeat/Auth/Auth.dart';
import 'package:tracktoeat/Auth/AuthUser.dart';
import 'package:tracktoeat/Screens/AllMenu.dart';
import 'package:tracktoeat/Screens/Login.dart';
import 'package:tracktoeat/Screens/Widgets/FoodCard.dart';
import 'package:tracktoeat/Theme.dart';


import '../Auth/Wrapper.dart';
import '../Database/Database.dart';
import '../Globals.dart';
import 'HomeMenu.dart';
import 'Loading.dart';
import 'RepMenu.dart';
import 'SuperAdminHome.dart';

class Home extends StatefulWidget {
  final AuthUser authUser;
  const Home({Key? key, required this.authUser}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(initialPage: 0);
  int selectedPage = 0;
  String userRole = primaryUser;
  bool loading = true;

  @override
  void initState(){
    firebaseAuth.User? user = widget.authUser.user;
    Database.getUserRole(user == null ? "" : (user.email??"")).then((value){
      widget.authUser.role = value;
      userRole = value;
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  List<Widget> getMenuBar(){
    if(userRole==messRep) {
      return [
        HomeMenu(authUser: widget.authUser,),
        AllMenu(authUser: widget.authUser,),
        RepMenu(authUser: widget.authUser,),
      ];
    }

    return [
      HomeMenu(authUser: widget.authUser,),
      AllMenu(authUser: widget.authUser,),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if(loading) {
      return Loading();
    }

    if(userRole==superAdmin){
      return const SuperAdminHome();
    }

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Track2Eat'),
        backgroundColor: LightTheme.deepIndigoAccent,
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return const Wrapper();}));
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          children: getMenuBar(),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: selectedPage == 0 ? LightTheme.deepIndigoAccent : Colors
                    .grey,
                onPressed: () {
                  _pageController.animateToPage(0, curve: Curves.easeIn, duration: const Duration(milliseconds: 500));
                  setState(() {
                    selectedPage = 0;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                color: selectedPage == 1 ? LightTheme.deepIndigoAccent : Colors
                    .grey,
                onPressed: () {
                  _pageController.animateToPage(1, curve: Curves.easeIn, duration: const Duration(milliseconds: 500));
                  setState(() {
                    selectedPage = 1;
                  });
                },
              ),

              if(userRole == messRep)
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  color: selectedPage == 2 ? LightTheme.deepIndigoAccent : Colors
                      .grey,
                  onPressed: () {
                    _pageController.animateToPage(2, curve: Curves.easeIn, duration: const Duration(milliseconds: 500));
                    setState(() {
                      selectedPage = 2;
                    });
                  },
                ),
            ],
          ),
        )
    ),
    );
  }
}
