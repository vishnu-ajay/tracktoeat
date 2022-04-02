import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Auth/Auth.dart';
import '../Auth/User.dart';
import '../Database/Database.dart';
import '../Theme.dart';

class ViewMessRep extends StatefulWidget {
  const ViewMessRep({Key? key}) : super(key: key);

  @override
  State<ViewMessRep> createState() => _ViewMessRepState();
}

class _ViewMessRepState extends State<ViewMessRep> {
  List<User> _list = [];

  @override
  void initState() {
    Database.getMessRep().then((value) {
      setState(() {
        _list = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: _list.isEmpty
            ? const Center(
                child: Text(
                  'No Mess Rep Added Yet!',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              )
            : ListView(
                children: List.generate(
                  _list.length,
                  (index) {
                    return ListTile(
                      title: Text(_list[index].email),
                      subtitle: Text(_list[index].role),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
