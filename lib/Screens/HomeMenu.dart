import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tracktoeat/Database/SearchFilter.dart';
import 'package:intl/intl.dart';

import '../Auth/AuthUser.dart';
import '../Database/Database.dart';
import '../Database/Food.dart';
import '../Theme.dart';
import 'FoodView.dart';
import 'Widgets/FoodCard.dart';

class HomeMenu extends StatefulWidget {
  final AuthUser authUser;
  const HomeMenu({Key? key, required this.authUser}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  List<Food> _allFood = [];
  List<Food> _list = [];
  List<String> messList = [];
  List<bool> selectedMess = [];
  bool loading = false;
  SearchFilter _searchFilter = SearchFilter(meal:(DateTime.now().hour >= 18) ? "Dinner" : "Snacks" , mess: [], day: DateFormat('EEEE').format(DateTime.now()), filter: SearchFilter.ratingHighToLow);

  @override
  void initState() {
    Database.getAllFood().then((value){
      setState(() {
        _allFood = value;
        _list = List.from(_allFood);
        applySearchFilters(_searchFilter);
        loading = false;
      });
    });
    super.initState();
  }

  Future<void> refreshData()async{
    setState(() {
      loading = true;
    });
    await Database.getAllFood().then((value){
      setState(() {
        _allFood = value;
        _list = List.from(_allFood);
        applySearchFilters(_searchFilter);
        loading = false;
      });
    });
  }

  void applySearchFilters(SearchFilter searchFilter){
    _list.clear();

    for(Food f in _allFood){
      if(searchFilter.meal!=null && searchFilter.meal!=f.mealType){
        continue;
      }
      if(searchFilter.day!=null&&searchFilter.day!=f.day){
        continue;
      }

      if(searchFilter.mess.isNotEmpty && (!searchFilter.mess.contains(f.mess))){
        continue;
      }

      _list.add(f);
    }

    if(searchFilter.filter == SearchFilter.ratingHighToLow){
      _list.sort((Food a, Food b){
        double ra = a.count == 0 ? 0 : a.rating/a.count;
        double rb = b.count == 0 ? 0 : b.rating/b.count;

        if(ra>rb){
          return 1;
        }

        return 0;
      });
    }else if(searchFilter.filter == SearchFilter.ratingLowToHigh){
      _list.sort((Food a, Food b){
        double ra = a.count == 0 ? 0 : a.rating/a.count;
        double rb = b.count == 0 ? 0 : b.rating/b.count;

        if(ra>rb){
          return 0;
        }

        return 1;
      });
    }
    else if(searchFilter.filter == SearchFilter.costHighToLow){
      _list.sort((Food a, Food b){
        if(a.price>b.price){
          return 1;
        }
        return 0;
      });
    }else if(searchFilter.filter == SearchFilter.costLowToHigh){
      _list.sort((Food a, Food b){
        if(a.price>b.price){
          return 0;
        }
        return 1;
      });
    }

    setState(() {
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.only(left: 60, top: 30, bottom: 5),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Hey!',
                  style: TextStyle(
                      color: LightTheme.darkGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 21),
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(left: 60, bottom: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Your suggested foods.',
                  style: TextStyle(
                      color: LightTheme.gray,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  child: Row(
                    children: [
                      const Spacer(),
                      const Center(
                        child: Text(
                          'Best Rated Snacks',
                          style: TextStyle(
                              color: LightTheme.darkGray,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                      const Spacer(),
                      Card(
                        child: IconButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            List<String> _mess = await Database.getAllMess();
                            setState(() {
                              messList = _mess;
                              selectedMess = List.filled(messList.length, false);
                              loading = false;
                            });
                            _searchFilter = SearchFilter(meal:(DateTime.now().hour >= 18) ? "Dinner" : "Snacks" , mess: [], day: DateFormat('EEEE').format(DateTime.now()), filter: SearchFilter.ratingHighToLow);
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height: 350,
                                      width: 300,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            child: ListView(
                                              children: List.generate(messList.length, (index) {
                                                return CheckboxListTile(
                                                    title: Text(messList[index]),
                                                    value: selectedMess[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedMess[index] = value??false;
                                                      });
                                                    });
                                              }),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5)),
                                            child: Container(
                                              height: 40,
                                              width: 150,
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
                                        ],
                                      ),
                                    ),
                                  );
                                });
                            _searchFilter.mess.clear();
                            for(int i=0;i<selectedMess.length;i++){
                              if(selectedMess[i]){
                                _searchFilter.mess.add(messList[i]);
                              }
                            }
                            applySearchFilters(_searchFilter);
                          },
                          icon: const Icon(Icons.more_vert),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 30),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    _searchFilter.day ?? "",
                    style: const TextStyle(
                        color: LightTheme.darkGray,
                        fontWeight: FontWeight.w500,
                        fontSize: 21),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              sliver: SliverList(
                delegate:
                    SliverChildBuilderDelegate((BuildContext context, int index) {
                  return GestureDetector(
                      onTap: ()async{
                        await Navigator.push(context, MaterialPageRoute(builder: (context){
                          return FoodView(food: _list[index], authUser: widget.authUser,);
                        },),);
                        await refreshData();
                      },
                      child: FoodCard(food: _list[index],authUser: widget.authUser,));
                }, childCount: _list.length),
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
    );
  }
}
