import 'package:flutter/material.dart';
import 'package:tracktoeat/Screens/FoodView.dart';

import '../../Auth/AuthUser.dart';
import '../../Database/Food.dart';
import '../../Globals.dart';
import '../../Theme.dart';
import 'StarRating.dart';

class FoodCard extends StatefulWidget {
  final Food food;
  final AuthUser authUser;
  const FoodCard({Key? key, required this.food, required this.authUser}) : super(key: key);


  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Card(
        child: SizedBox(
          height: 130,
          width: 350,
          child: Row(
            children:[
              const SizedBox(width: 10,),
              if(widget.food.imageUrl=="")
                SizedBox(
                    height: 75,width: 75,
                    child: Image.asset('assets/burger.jpg',height: 75,width: 75,fit: BoxFit.fill,)),
              if(widget.food.imageUrl!="")
                SizedBox(
                    height: 75,width: 75,
                    child: Image.network(widget.food.imageUrl,height: 75,width: 75,fit: BoxFit.fill,)),
              const SizedBox(width: 30,),
              SizedBox(
                width: 140,
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    SizedBox(
                      width:150,
                      child: Text(widget.food.mess,
                        style: TextStyle(
                            color: lightTheme.value
                                ? LightTheme.darkGray
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width:150,
                      child: Text(widget.food.mealName,
                        style: TextStyle(
                            color: lightTheme.value
                                ? LightTheme.darkGray
                                : Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                        ),),
                    ),
                    const SizedBox(height: 15,),
                    StarRating(
                      rating: (widget.food.count == 0) ? 0 : (widget.food.rating/widget.food.count),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: const Alignment(0,0.9),
                child: SizedBox(
                    height: 50,
                    width: 70,
                    child: Center(
                      child: Text('${widget.food.price}/-',
                        style: TextStyle(
                            color: lightTheme.value
                                ? LightTheme.darkGray
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 13
                        ),),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
