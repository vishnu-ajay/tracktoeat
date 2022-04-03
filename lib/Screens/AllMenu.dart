import 'package:flutter/material.dart';
import 'package:tracktoeat/Auth/AuthUser.dart';
import 'package:tracktoeat/Database/Database.dart';
import 'package:tracktoeat/Database/SearchFilter.dart';
import 'package:intl/intl.dart';

import '../Database/Food.dart';
import '../Theme.dart';
import 'FoodView.dart';
import 'MenuEditFilters.dart';
import 'Widgets/FoodCard.dart';

class AllMenu extends StatefulWidget {
  final AuthUser authUser;
  const AllMenu({Key? key, required this.authUser}) : super(key: key);

  @override
  State<AllMenu> createState() => _AllMenuState();
}

class _AllMenuState extends State<AllMenu> {

  List<Food> _allFood = [];
  List<Food> _list = [];

  SearchFilter _searchFilter = SearchFilter(meal: null, mess: [], day: DateFormat('EEEE').format(DateTime.now()), filter: SearchFilter.ratingHighToLow);

  bool loading = true;

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
    return CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.only(top: 30, bottom: 5),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w500,
                          fontSize: 21),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      width: 250,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: GestureDetector(
                          onTap: ()async{
                            _searchFilter = await Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const MenuEditFilters();
                            },),);
                            applySearchFilters(_searchFilter);
                          },
                          child: Container(
                            color: LightTheme.deepIndigoAccent,
                            width: 250,
                            height: 50,
                            child: const Center(
                              child: Text(
                                'Edit Filters',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                    return Center(
                      child: GestureDetector(
                        onTap: ()async{
                          await Navigator.push(context, MaterialPageRoute(builder: (context){
                            return FoodView(food: _list[index], authUser: widget.authUser,);
                          },),);
                          await refreshData();
                        },
                        child: FoodCard(
                            food: _list[index],
                          authUser: widget.authUser,
                        ),
                      ),
                    );
                  }, childCount: _list.length),
                ),
              ),
            ],
          );
  }
}
