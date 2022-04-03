import 'package:flutter/material.dart';
import 'package:tracktoeat/Globals.dart';
import 'package:tracktoeat/Theme.dart';

import '../../Database/Food.dart';

class InteractiveStarRating extends StatefulWidget {
  final double? starSize;
  final double? width;
  final int rating;
  const InteractiveStarRating({Key? key, this.starSize, this.width, required this.rating}) : super(key: key);

  @override
  State<InteractiveStarRating> createState() => _InteractiveStarRatingState();
}

class _InteractiveStarRatingState extends State<InteractiveStarRating> {
  int rating = 0;

  @override
  void initState(){
    rating = widget.rating;
    super.initState();
  }


  List<Widget> getRow(){

    double _starSize = widget.starSize ?? 20;

    List<Widget> _list = [];

    _list.add(const Spacer());

    for(int i=0;i<rating;i++) {
      _list.add(
          IconButton(
            onPressed: (){
              setState(() {
                rating = i+1;
                foodRating = rating;
              });
            },
            icon: Icon(
              Icons.star,
              color: Colors.amber,
              size: _starSize,
            ),
          )
      );
    }

    for(int i=rating;i<5;i++){
      _list.add(
          IconButton(
            onPressed: (){
              setState(() {
                foodRating = i+1;
                rating = i+1;
              });
            },
            icon: Icon(
              Icons.star_border,
              color: Colors.amber,
              size: _starSize,
            ),
          )
      );
    }

      _list.add(const Spacer());

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 150,
      child: Row(
        children: getRow(),
      ),
    );
  }
}
