import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tracktoeat/Database/MessDetails.dart';

import '../Auth/Auth.dart';
import '../Database/Database.dart';
import '../Theme.dart';

class MessDetailsView extends StatefulWidget {
  final String messName;
  const MessDetailsView({Key? key,required this.messName}) : super(key: key);

  @override
  State<MessDetailsView> createState() => _MessDetailsViewState();
}

class _MessDetailsViewState extends State<MessDetailsView> {

  MessDetails _details = MessDetails(managerPhoneNo: "",messLocation: "",messRepEmail: "",messRepName: "",nameOfMess: "");
  bool loading = true;

  @override
  void initState() {
    Database.getMessDetails(widget.messName).then((value){
      setState(() {
        _details = value;
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
      body: Stack(
        children: [
          if(!loading)
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      widget.messName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                    'Mess Representative:',
                      style:TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      _details.messRepName,
                      style: const TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Mess Representative Email:',
                      style:TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      _details.messRepEmail,
                      style: const TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Mess Manager Contact:',
                      style:TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      _details.managerPhoneNo,
                      style: const TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Mess Manager Contact:',
                      style:TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: LightTheme.deepIndigoAccent)
                      ),
                      child: Image.network('https://docs.microsoft.com/en-us/azure/azure-maps/media/migrate-google-maps-web-app/simple-google-map.png'),
                    ),
                  ),
                ),
              ),
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
    ));
  }
}
