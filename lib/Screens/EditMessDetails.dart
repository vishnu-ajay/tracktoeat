import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tracktoeat/Database/MessDetails.dart';

import '../Auth/Auth.dart';
import '../Database/Database.dart';
import '../Theme.dart';

class EditMessDetails extends StatefulWidget {
  final String messName;
  const EditMessDetails({Key? key,required this.messName}) : super(key: key);

  @override
  State<EditMessDetails> createState() => _EditMessDetailsState();
}

class _EditMessDetailsState extends State<EditMessDetails> {
  final _formKey = GlobalKey<FormState>();
  MessDetails originalDetails = MessDetails(nameOfMess: "", messRepEmail:"", messRepName: "", messLocation: "", managerPhoneNo: "");
  MessDetails messDetails = MessDetails(nameOfMess: "", messRepEmail:"", messRepName: "", messLocation: "", managerPhoneNo: "");
  final _messNameController = TextEditingController(text: "");
  final _messRepNameController = TextEditingController(text: "");
  final _messRepEmailController = TextEditingController(text: "");
  final _messLocationController = TextEditingController(text: "");
  final _messManagerPhoneController = TextEditingController(text: "");

  bool loading = true;

  @override
  void initState() {
    Database.getMessDetails(widget.messName).then((value){
      setState(() {
        originalDetails = value;
        _messRepNameController.text = value.messRepName;
        _messLocationController.text = value.messLocation;
        _messManagerPhoneController.text = value.managerPhoneNo;
        _messNameController.text = value.nameOfMess;
        _messRepEmailController.text = value.messRepEmail;
        messDetails = MessDetails(nameOfMess: value.nameOfMess, messRepEmail: value.messRepEmail, messRepName: value.messRepName, messLocation: value.messLocation, managerPhoneNo: value.managerPhoneNo);
        loading = false;
      });
    });
    super.initState();
  }

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
                                controller: _messNameController,
                                onChanged: (value) {
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
                                  disabledBorder: OutlineInputBorder(
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
                                controller: _messRepNameController,
                                onChanged: (value) {
                                  setState(() {
                                    messDetails.messRepName = value;
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
                                controller: _messRepEmailController,
                                onChanged: (value) {
                                  setState(() {
                                    messDetails.messRepEmail = value;
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
                                controller: _messLocationController,
                                onChanged: (value) {
                                  setState(() {
                                    messDetails.messLocation = value;
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
                                controller: _messManagerPhoneController,
                                onChanged: (value) {
                                  setState(() {
                                    messDetails.managerPhoneNo = value;
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

                            await Database.deleteMessDetails(originalDetails);


                            await Database.addMess(messDetails).then((value){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: LightTheme.deepIndigoAccent,content: Text('Updated mess successfully!',style: TextStyle(color: LightTheme.white),)));

                            }).catchError((error){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.deepOrange,content: Text('Failed to add mess!',style: TextStyle(color: LightTheme.white),)));
                            });

                            setState(() {
                              loading = false;
                            });

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
