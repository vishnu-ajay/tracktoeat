import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tracktoeat/Database/SearchFilter.dart';

import '../Database/Database.dart';
import '../Theme.dart';

class MenuEditFilters extends StatefulWidget {
  const MenuEditFilters({Key? key}) : super(key: key);

  @override
  State<MenuEditFilters> createState() => _MenuEditFiltersState();
}

class _MenuEditFiltersState extends State<MenuEditFilters> {
  String dropdownValue = 'Tuesday';
  String meal = 'Snacks';
  String filterVal = SearchFilter.ratingHighToLow;
  List<String> messList = [];
  List<bool> selectedMess = [];
  bool loading = true;

  @override
  void initState() {
    Database.getAllMess().then((value){
      setState(() {
        messList = value;
        selectedMess = List.filled(messList.length, false);
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
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
      body: Stack(
        children: [
          SizedBox(
            height: height,
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid.count(crossAxisCount: 2,
                        children: [
                          Container(
                            height: 200,
                            width: min(200,width / 2),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 1.5,
                                  color: Colors.grey,
                                ),
                                bottom: BorderSide(
                                  width: 1.5,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                    'Meal',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: Center(
                                      child: Container(
                                        height: 45,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: LightTheme.deepIndigoAccent,
                                          ),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(value: 'Snacks', groupValue: meal, onChanged: (String? value) {
                                              setState(() {
                                                meal = value??'';
                                              });
                                            },),
                                            const Text(
                                              'Snacks',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: Center(
                                      child: Container(
                                        height: 45,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: LightTheme.deepIndigoAccent,
                                          ),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(value: 'Dinner', groupValue: meal, onChanged: (String? value) {
                                              setState(() {
                                                meal = value ?? '';
                                              });
                                            },),
                                            const Text(
                                              'Dinner',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width:  min(200,width / 2),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.5,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                    'Day',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  child: Container(
                                    color: LightTheme.deepIndigoAccent,
                                    width: 150,
                                    child: Center(
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        dropdownColor: LightTheme.deepIndigoAccent  ,
                                        icon: const Icon(Icons.keyboard_arrow_down,color: LightTheme.white,),
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400),
                                        underline: Container(
                                          height: 0,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>['Sunday', 'Monday', 'Tuesday', 'Wednesday','Thursday','Friday','Saturday']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: min(200,width / 2),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 1.5,
                                  color: Colors.grey,
                                ),
                                bottom: BorderSide(
                                  width: 1.5,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                    'Rating',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: Center(
                                      child: Container(
                                        height: 45,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: LightTheme.deepIndigoAccent,
                                          ),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(value: SearchFilter.ratingHighToLow, groupValue:filterVal, onChanged: (String? value) {
                                              setState(() {
                                                filterVal = value??SearchFilter.ratingHighToLow;
                                              });
                                            },),
                                            const Text(
                                              'High-Low',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: Center(
                                      child: Container(
                                        height: 45,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: LightTheme.deepIndigoAccent,
                                          ),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(value: SearchFilter.ratingLowToHigh, groupValue:filterVal, onChanged: (String? value) {
                                              setState(() {
                                                filterVal = value??SearchFilter.ratingHighToLow;
                                              });
                                            },),
                                            const Text(
                                              'Low-High',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: min(200,width / 2),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 1.5,
                                  color: Colors.grey,
                                ),
                                bottom: BorderSide(
                                  width: 1.5,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                const Center(
                                  child: Text(
                                    'Cost',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: Center(
                                      child: Container(
                                        height: 45,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: LightTheme.deepIndigoAccent,
                                          ),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(value: SearchFilter.costLowToHigh, groupValue:filterVal, onChanged: (String? value) {
                                              setState(() {
                                                filterVal = value??SearchFilter.ratingHighToLow;
                                              });
                                            },),
                                            const Text(
                                              'High-Low',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 50,
                                    width: 180,
                                    child: Center(
                                      child: Container(
                                        height: 45,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: LightTheme.deepIndigoAccent,
                                          ),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(value: SearchFilter.costHighToLow, groupValue:filterVal, onChanged: (String? value) {
                                              setState(() {
                                                filterVal = value??SearchFilter.ratingHighToLow;
                                              });
                                            },),
                                            const Text(
                                              'Low-High',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            if (index == 0) {
                              return const SizedBox(
                                width: 100,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    'Mess',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }
                            index--;
                            return CheckboxListTile(
                                title: Text(messList[index]),
                                value: selectedMess[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedMess[index] = value??false;
                                  });
                                });
                          },
                          childCount: messList.length+1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),]
                    ),
                    child:  Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: GestureDetector(
                          onTap: (){
                            List<String> _messes = [];
                            for(int i=0;i<messList.length;i++){
                              if(selectedMess[i]) {
                                _messes.add(messList[i]);
                              }
                            }
                            SearchFilter searchFilter = SearchFilter(meal: meal,mess: _messes, day: dropdownValue, filter: filterVal);
                            Navigator.pop(context,searchFilter);
                            },
                          child: Container(
                            height: 50,
                            width: 200,
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
                    ),
                  ),
                ),
              ],
            ),
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
      )
    ));
  }
}
