import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tracktoeat/Auth/Auth.dart';

import '../Theme.dart';
import 'AddMess.dart';
import 'EditMess.dart';
import 'ViewMessRep.dart';

class SuperAdminHome extends StatefulWidget {
  const SuperAdminHome({Key? key}) : super(key: key);

  @override
  State<SuperAdminHome> createState() => _SuperAdminHomeState();
}

class _SuperAdminHomeState extends State<SuperAdminHome> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    height = max(height-200, 480);

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
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const EditMess();
                      }));
                    },
                    child: Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: LightTheme.deepIndigoAccent,
                          )),
                      child: const Center(
                        child: Text(
                          'Edit/Delete Mess',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const AddMess();
                      }));
                    },
                    child: Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: LightTheme.deepIndigoAccent,
                          )),
                      child: const Center(
                        child: Text(
                          'Add Mess',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const ViewMessRep();
                      }));
                    },
                    child: Container(
                      height: 60,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: LightTheme.deepIndigoAccent,
                          )),
                      child: const Center(
                        child: Text(
                          'View Mess Rep',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: LightTheme.deepIndigoAccent,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
