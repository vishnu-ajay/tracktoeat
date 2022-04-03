import 'package:shared_preferences/shared_preferences.dart';

import 'Food.dart';

class LocalDB{

  static Future<void> saveRating(Food food, String email, int rating)async{
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString(email+';'+food.mess+';'+food.mealType+';'+food.mealType+';'+food.day, '$rating;${DateTime.now().millisecondsSinceEpoch}');
  }

  static Future<String> getRating(Food food, String email)async{
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    return _prefs.getString(email+';'+food.mess+';'+food.mealType+';'+food.mealType+';'+food.day) ?? "";
  }
}