import 'package:flutter/material.dart';

import '../Theme.dart';
import 'Widgets/FoodCard.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 350,
                                width: 300,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:300,
                                      child: ListView(
                                        children: List.generate(7, (index) {
                                          return CheckboxListTile(
                                              title: Text('$index'),
                                              value: false,
                                              onChanged: (value) {
                                                print('hello');
                                              });
                                        }),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
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
