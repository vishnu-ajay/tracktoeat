import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tracktoeat/Screens/EditMessDetails.dart';

import '../Auth/Auth.dart';
import '../Database/Database.dart';
import '../Theme.dart';

class EditMess extends StatefulWidget {
  const EditMess({Key? key}) : super(key: key);

  @override
  State<EditMess> createState() => _EditMessState();
}

class _EditMessState extends State<EditMess> {
  List<String> _mess = [];
  bool loading = true;

  @override
  void initState() {
    Database.getAllMess().then((value) {
      setState(() {
        _mess = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Edit Mess'),
              backgroundColor: LightTheme.deepIndigoAccent,
            ),
            body: Stack(
              children: [
                ListView(
                  children: List.generate(_mess.length+1 , (index) {
                    if(index == 0){
                      return const SizedBox(height: 20,);
                    }
                    index--;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          tileColor: LightTheme.deepIndigoAccent,
                          textColor: Colors.white,
                          title: Text(_mess[index]),
                          trailing: SizedBox(
                            width: 150,
                            child: Row(
                              children: [
                                const Spacer(),
                                Container(
                                    color: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return EditMessDetails(messName: _mess[index]);
                                          }));
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: LightTheme.deepIndigoAccent,
                                        ),),),
                                const Spacer(),
                                Container(
                                    color: Colors.white,
                                    child: IconButton(
                                        onPressed: ()async{

                                          bool result = await showDialog(
                                            barrierDismissible: false,
                                              context: context, builder: (BuildContext context){
                                            return AlertDialog(
                                              content: SizedBox(
                                                height: 200,
                                                width: 200,
                                                child: Column(
                                                  children: [
                                                    const Spacer(),
                                                    const Text(
                                                      'Are you sure you want to delete?',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    const Spacer(flex: 2,),
                                                    Row(
                                                      children: [
                                                        const Spacer(),
                                                        ClipRRect(
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(5)),
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              Navigator.pop(context,false);
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: 80,
                                                              color: Colors.deepOrange,
                                                              child: const Center(
                                                                child: Text(
                                                                  'Discard',
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        ClipRRect(
                                                          borderRadius: const BorderRadius.all(
                                                              Radius.circular(5)),
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              Navigator.pop(context,true);
                                                            },
                                                            child: Container(
                                                              height: 40,
                                                              width: 80,
                                                              color: LightTheme.deepIndigoAccent,
                                                              child: const Center(
                                                                child: Text(
                                                                  'Confirm',
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                    const Spacer(),

                                                  ],
                                                ),
                                              ),
                                            );
                                          });

                                          if(!result){
                                            return;
                                          }

                                          setState(() {
                                            loading = true;
                                          });

                                          await Database.deleteMessDetails(await Database.getMessDetails(_mess[index]));

                                          _mess = await Database.getAllMess();

                                          setState(() {
                                            loading = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.clear,
                                          color: LightTheme.deepIndigoAccent,
                                        ),),),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                if (loading)
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                if (loading)
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
            )));
  }
}
