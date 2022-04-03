import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double? starSize;
  final double? width;
  final bool? center;
  final bool? spaced;
  const StarRating({Key? key,required this.rating, this.starSize, this.width, this.center,this.spaced}) : super(key: key);

  List<Widget> getSpacedRow(){

    double _starSize = starSize ?? 20;

    List<Widget> _list = [];

    if(center == true){
      _list.add(const Spacer());
    }

    int rt = (rating*2).round();

    bool haveHalf = (rt%2!=0);

    rt = rt~/2;

    for(int i=0;i<rt;i++) {
      _list.add(
          IconButton(
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.star,
              color: Colors.amber,
              size: _starSize,
            ), onPressed: () { },
          )
      );
    }


      if(haveHalf){
        _list.add(
            IconButton(
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.star_half,
                color: Colors.amber,
                size: _starSize,
              ), onPressed: () {  },
            )
        );
        rt++;
      }

      for(int i=rt;i<5;i++){
        _list.add(
            IconButton(
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.star_border,
                color: Colors.amber,
                size: _starSize,
              ), onPressed: () {  },
            )
        );
      }

    _list.add(IconButton(
      splashColor: Colors.transparent,
      onPressed: (){},
      icon: Icon(
        Icons.check,
        color: Colors.transparent,
        size: _starSize-10,
      ),
    ),);

    if(center == true){
      _list.add(const Spacer());
    }
    return _list;
  }

  List<Widget> getRow(){

    double _starSize = starSize ?? 20;

    List<Widget> _list = [];

    if(center == true){
      _list.add(const Spacer());
    }

    int rt = (rating*2).round();

    bool haveHalf = (rt%2!=0);

    rt = rt~/2;

    for(int i=0;i<rt;i++) {
      _list.add(
        Icon(
              Icons.star,
              color: Colors.amber,
              size: _starSize,
          )
      );
    }


    if(haveHalf){
      _list.add(
        Icon(
              Icons.star_half,
              color: Colors.amber,
              size: _starSize,
          ),
      );
      rt++;
    }

    for(int i=rt;i<5;i++){
      _list.add(
           Icon(
              Icons.star_border,
              color: Colors.amber,
              size: _starSize,
            ),

      );
    }

    if(center == true){
      _list.add(const Spacer());
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 150,
      child: Row(
        children: (spaced == true)? getSpacedRow() : getRow(),
      ),
    );
  }
}
