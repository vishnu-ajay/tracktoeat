import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tracktoeat/Screens/Widgets/StarRating.dart';

import '../Auth/Auth.dart';
import '../Auth/AuthUser.dart';
import '../Auth/Wrapper.dart';
import '../Database/Database.dart';
import '../Database/Food.dart';
import '../Database/LocalDB.dart';
import '../Globals.dart';
import '../Theme.dart';
import 'Widgets/InteractiveStarRating.dart';

class FoodView extends StatefulWidget {
  final Food food;
  final AuthUser authUser;
  const FoodView({Key? key, required this.food, required this.authUser}) : super(key: key);

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  bool loading = true;
  int rating = 0, editTime = -1;

  @override
  void initState() {
    editTime = DateTime.now().millisecondsSinceEpoch;
    LocalDB.getRating(widget.food, widget.authUser.user!.email??"").then((value) {
      try {
        List<String>_tmp = value.split(';');
        rating = int.parse(_tmp[0]);
        editTime = int.parse(_tmp[1]);
      }catch(e){
        print(e.toString());
        print('^'*50);
        rating = 0;
        editTime = -1;
      }
      setState(() {
        foodRating = 0;
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
          title: const Text('Track2Eat'),
          backgroundColor: LightTheme.deepIndigoAccent,
          actions: [
            IconButton(
              onPressed: () {
                AuthService().logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const Wrapper();
                }));
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
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: Image.network(
                            widget.food.imageUrl,
                            height: 250,
                            width: 250,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        widget.food.mess,
                        style: const TextStyle(
                            color: LightTheme.darkGray,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        widget.food.mealName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: LightTheme.darkGray,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        widget.food.day,
                        style: const TextStyle(
                            color: LightTheme.darkGray,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 30, bottom: 10,left: 40),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Give Your Rating:',
                      style: TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Spacer(),
                        InteractiveStarRating(starSize: 35, width: 300,rating: rating,),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            int now = DateTime.now().millisecondsSinceEpoch;
                            print(editTime);
                            if((now-editTime) <= 86400000){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.deepOrange,content: Text('You can rate only once in 24hrs!',style: TextStyle(color: LightTheme.white),)));
                              return;
                            }

                            setState(() {
                              loading = true;
                            });

                            widget.food.rating+=foodRating;
                            widget.food.count++;

                            if(widget.food.count == 100){
                              widget.food.prevRating = widget.food.rating;
                              widget.food.count = widget.food.count;
                            }else if(widget.food.count == 200){
                              int last100Rating = widget.food.rating - widget.food.prevRating;
                              int last100Count = widget.food.count - widget.food.prevCount;
                              widget.food.prevRating = 0;
                              widget.food.count = 0;
                              widget.food.rating = last100Rating;
                              widget.food.count = last100Count;
                            }

                            await Database.setFood(widget.food);

                            await LocalDB.saveRating(widget.food, widget.authUser.user!.email??"", foodRating);

                            setState(() {
                              editTime = DateTime.now().millisecondsSinceEpoch;
                              loading = false;
                            });

                            },
                          icon: const Icon(
                            Icons.check,
                            color: LightTheme.caribbeanGreen,
                            size: 30,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 30, bottom: 10,left: 40),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Overall Rating:',
                      style: TextStyle(
                          color: LightTheme.darkGray,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        const Spacer(),
                        StarRating(
                          starSize: 35,
                          width: 300,
                          center: true,
                          spaced: true,
                          rating: (widget.food.count == 0)
                              ? 0
                              : widget.food.rating / widget.food.count,
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          onPressed: ()  {
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Colors.transparent,
                            size: 30,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only( bottom: 10),
                  sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 60,
                            width: 100,
                            child: Column(
                              children: [
                                const Text(
                                  'Price:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.food.price}/-',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )),
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
      ),
    );
  }
}
