import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tracktoeat/Auth/AuthUser.dart';
import 'package:tracktoeat/Screens/AllMenu.dart';
import 'package:tracktoeat/Screens/Widgets/FoodCard.dart';
import 'package:tracktoeat/Theme.dart';

import '../Globals.dart';
import 'HomeMenu.dart';
import 'RepMenu.dart';

class Home extends StatefulWidget {
  final AuthUser authUser;
  const Home({Key? key, required this.authUser}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(initialPage: 0);
  int selectedPage = 0;

  List<Widget> getMenuBar(){
    if(widget.authUser.role==messRep) {
      return const [
        HomeMenu(),
        AllMenu(),
        // RepMenu(),
      ];
    }

    return const[
       RepMenu(),
      // HomeMenu(),
      AllMenu(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Track2Eat'),
        backgroundColor: LightTheme.deepIndigoAccent,
        actions: [
          IconButton(
            onPressed: () {},
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
            ],
          ),
        )
    ),
    );
  }
}
