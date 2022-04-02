import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Auth/Auth.dart';
import '../Theme.dart';

class AddMess extends StatefulWidget {
  const AddMess({Key? key}) : super(key: key);

  @override
  State<AddMess> createState() => _AddMessState();
}

class _AddMessState extends State<AddMess> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Track2Eat'),
        backgroundColor: LightTheme.deepIndigoAccent,
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(color: DarkTheme.greenAccent,),
    ));
  }
}
