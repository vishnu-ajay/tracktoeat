import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  const StarRating({Key? key,required this.rating}) : super(key: key);

  List<Widget> getRow(){
    List<Widget> _list = [];

    int rt = (rating*2).round();

    bool haveHalf = (rt%2!=0);

    rt = rt~/2;

    for(int i=0;i<rt;i++) {
      _list.add(
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 20,
          )
      );
    }


      if(haveHalf){
        _list.add(
            const Icon(
              Icons.star_half,
              color: Colors.amber,
              size: 20,
            )
        );
        rt++;
      }

      for(int i=rt;i<5;i++){
        _list.add(
            const Icon(
              Icons.star_border,
              color: Colors.amber,
              size: 20,
            )
        );
      }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: getRow(),
      ),
    );
  }
}
