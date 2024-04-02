import 'package:flutter/foundation.dart';

class SelectedCourse extends ChangeNotifier {
  String _course_name = "";
  String _tutor = "";
  String _price = "";
  String _lectures_link = "";
  int _rating = 0;
  String _category = "";
  String _sub_category = "";
//Setter
  void setValues(String course_name, String tutor, String price,
      String lecture_link, int rating, String category, String sub_category) {
    _course_name = course_name;
    _category = category;
    _lectures_link = lecture_link;
    _price = price;
    _sub_category = sub_category;
    _tutor = tutor;
    _rating = rating;
    notifyListeners();
  }

  showvalues() {
    print("Course Name = ${_course_name}");
    print("Category Name = ${_category}");
    print("Sub Category Name = ${_sub_category}");
  }

// Getter
  String get get_course_name => _course_name;
  String get get_tutor => _tutor;
  String get get_price => _price;
  String get get_lecture_link => _lectures_link;
  int get get_rating => _rating;
  String get get_category => _category;
  String get get_sub_category => _sub_category;
}
