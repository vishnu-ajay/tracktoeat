class Food {
  String day;
  String mealName;
  String mealType;
  String imageUrl;
  String mess;
  int prevRating;
  int prevCount;
  int rating;
  int count;
  double price;

  Food(
      {required this.day,
      required this.mealName,
      required this.mealType,
      required this.imageUrl,
      required this.mess,
        required this.prevRating,
        required this.prevCount,
      required this.rating,
      required this.price,
      required this.count});

  Food.fromJson(Map<String, dynamic> json)
      : day = json['day']??"",
        mealType = json['mealType']??"",
        mess = json['mess']??"",
        mealName = json['mealName']??"",
        imageUrl = json['imageUrl']??"",
        price = json['price']??0,
        count = json['count'] ?? 0,
        rating = json['rating'] ?? 0,
        prevRating = json['prevRating'] ?? 0,
        prevCount = json['prevCount'] ?? 0;

  Map<String,dynamic> toJson()=>{
    'day':day,
    'mealType':mealType,
    'mealName':mealName,
    'mess':mess,
    'imageUrl':imageUrl,
    'price':price,
    'count':count,
    'rating':rating,
    'prevRating':prevRating,
    'prevCount':prevCount
  };
}
