import 'package:flutter/material.dart';

import '../Auth/Auth.dart';
import '../Theme.dart';

class EditMess extends StatefulWidget {
  const EditMess({Key? key}) : super(key: key);

  @override
  State<EditMess> createState() => _EditMessState();
}

class _EditMessState extends State<EditMess> {
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
      body: Container(
        color: Colors.pink,
      ),
    ));
  }
}
