import 'package:flutter/material.dart';

import '../../Globals.dart';
import '../../Theme.dart';
import 'StarRating.dart';


class FoodCard extends StatelessWidget {
  final String mess, foodName;
  final double price, rating;
  const FoodCard({Key? key, required this.mess, required this.foodName, required this.price, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Card(
        child: SizedBox(
          height: 120,
          width: 250,
          child: Row(
            children:[
            SizedBox(
            height: 75,width: 75,
                child: Image.asset('assets/burger.jpg',height: 75,width: 75,fit: BoxFit.fill,)),
              const SizedBox(width: 40,),
              SizedBox(
                width: 150,
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    SizedBox(
                      width:150,
                      child: Text(mess,
                        style: TextStyle(
                            color: lightTheme.value
                                ? LightTheme.darkGray
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 21
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width:150,
                      child: Text(foodName,
                        style: TextStyle(
                            color: lightTheme.value
                                ? LightTheme.darkGray
                                : Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18
                        ),),
                    ),
                    const SizedBox(height: 15,),
                    StarRating(
                      rating: rating,
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: const Alignment(0,0.9),
                child: Container(
                  height: 50,
                    width: 70,
                    padding: const EdgeInsets.only(right: 5),
                    child: Text('$price/-',
                      style: TextStyle(
                          color: lightTheme.value
                              ? LightTheme.darkGray
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),)),
              ),
          ],
          ),
        ),
      ),
    );
  }
}
