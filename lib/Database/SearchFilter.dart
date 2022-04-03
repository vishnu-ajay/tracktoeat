class SearchFilter{
  static const String ratingLowToHigh = 'ratingLowToHigh';
  static const String ratingHighToLow = 'ratingHighToLow';
  static const String costLowToHigh = 'costLowToHigh';
  static const String costHighToLow = 'costHighToLow';
  static const Map<String,int> filterMap = {
    ratingLowToHigh: 0,
    ratingHighToLow: 1,
    costLowToHigh: 2,
    costHighToLow:3
  };
  final String? filter;
  final String? meal;
  final List<String> mess;
  final String? day;
  SearchFilter({required this.meal,required this.mess, required this.day, required this.filter});

  @override
  String toString() {
    return 'SearchFilter{filter: $filter, meal: $meal, mess: $mess, day: $day}';
  }
}