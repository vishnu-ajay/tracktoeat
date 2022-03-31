import 'package:flutter/material.dart';

import '../Theme.dart';
import 'MenuEditFilters.dart';
import 'Widgets/FoodCard.dart';

class AllMenu extends StatefulWidget {
  const AllMenu({Key? key}) : super(key: key);

  @override
  State<AllMenu> createState() => _AllMenuState();
}

class _AllMenuState extends State<AllMenu> {
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
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const MenuEditFilters();
                            },),);
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
              const SliverPadding(
                padding: EdgeInsets.only(bottom: 30),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Tuesday',
                      style: TextStyle(
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
                    return const FoodCard(
                        mess: 'A-Mess', foodName: 'Burger', price: 50, rating: 3.5);
                  }, childCount: 20),
                ),
              ),
            ],
          );
  }
}
