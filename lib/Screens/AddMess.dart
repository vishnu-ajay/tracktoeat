import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracktoeat/Database/MessDetails.dart';

import '../Auth/Auth.dart';
import '../Database/Database.dart';
import '../Theme.dart';

class AddMess extends StatefulWidget {
  const AddMess({Key? key}) : super(key: key);

  @override
  State<AddMess> createState() => _AddMessState();
}

class _AddMessState extends State<AddMess> {
  final _formKey = GlobalKey<FormState>();
  String nameOfMess = "";
  String messRepName = "";
  String messRepEmail = "";
  String messLocation = "";
  String managerPhoneNo = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Add Mess'),
        backgroundColor: LightTheme.deepIndigoAccent,
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(top: 40),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Name of Mess',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    nameOfMess = value;
                                  });
                                },
                                validator: (val) {
                                  if (val != null && val.isNotEmpty) {
                                    return null;
                                  }
                                  return 'Mess name cannot be empty!';
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: LightTheme.deepIndigoAccent,
                                    ),
                                  ),
                                  focusedErrorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 40),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mess Representative name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    messRepName = value;
                                  });
                                },
                                validator: (val) {
                                  if (val != null && val.isNotEmpty) {
                                    return null;
                                  }
                                  return 'Name of Mess Rep cannot be empty!';
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: LightTheme.deepIndigoAccent,
                                    ),
                                  ),
                                  focusedErrorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 40),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mess Representative email',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    messRepEmail = value;
                                  });
                                },
                                validator: (val) {
                                  if (val != null && val.isNotEmpty) {
                                    return null;
                                  }
                                  return 'Email of Mess Rep cannot be empty!';
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: LightTheme.deepIndigoAccent,
                                    ),
                                  ),
                                  focusedErrorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 40),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mess Location',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    messLocation = value;
                                  });
                                },
                                validator: (val) {
                                  if (val != null && val.isNotEmpty) {
                                    return null;
                                  }
                                  return 'Mess Location cannot be empty!';
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: LightTheme.deepIndigoAccent,
                                    ),
                                  ),
                                  focusedErrorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 40),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mess Manager Mobile Number',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    managerPhoneNo = value;
                                  });
                                },
                                validator: (val) {
                                  if (val != null && val.isNotEmpty) {
                                    return null;
                                  }
                                  return "Manager's mobile number cannot be empty!";
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: LightTheme.deepIndigoAccent,
                                    ),
                                  ),
                                  focusedErrorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(padding: const EdgeInsets.only(top: 20,bottom: 10),
                sliver:SliverToBoxAdapter(
                  child: Center(
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                      child: GestureDetector(
                        onTap: ()async{
                          if(_formKey.currentState==null){
                            return;
                          }
                          if(!_formKey.currentState!.validate()){
                            return;
                          }

                          setState(() {
                            loading = true;
                          });

                          bool messExists = await Database.messAlreadyExists(nameOfMess);

                          if(messExists){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.deepOrange,content: Text('Mess Already Exists!',style: TextStyle(color: LightTheme.white),)));
                            setState(() {
                              loading = false;
                            });
                            return;
                          }

                          bool isMessRepOfOther = await Database.isMessRepOfOther(messRepEmail, nameOfMess);

                          if(isMessRepOfOther){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.deepOrange,content: Text('Is already a Mess Rep of another mess!',style: TextStyle(color: LightTheme.white),)));
                            setState(() {
                              loading = false;
                            });
                            return;
                          }

                          bool isSuperAdmin = await Database.isSuperAdmin(messRepEmail);

                          if(isSuperAdmin){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.deepOrange,content: Text('Super Admin cannot be assigned as Mess Rep',style: TextStyle(color: LightTheme.white),)));
                            setState(() {
                              loading = false;
                            });
                            return;
                          }


                          await Database.addMess(MessDetails(nameOfMess: nameOfMess, messRepEmail: messRepEmail, messRepName: messRepName, messLocation: messLocation, managerPhoneNo: managerPhoneNo)).then((value){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: LightTheme.deepIndigoAccent,content: Text('Added mess successfully!',style: TextStyle(color: LightTheme.white),)));

                          }).catchError((error){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.deepOrange,content: Text('Failed to add mess!',style: TextStyle(color: LightTheme.white),)));
                          });

                          setState(() {
                            loading = false;
                          });

                          Navigator.pop(context);

                          },
                        child: Container(
                          height: 50,
                          width: 150,
                          color: LightTheme.deepIndigoAccent,
                          child: const Center(
                            child: Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),),
              ],
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
        ),
      ),
    ));
  }
}
