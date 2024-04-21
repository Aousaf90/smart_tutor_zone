import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCoursesProvider extends ChangeNotifier {
  List _allCourses = [];
  List _allCategories = [];
  List _allsubCategories = [];
  List _addData = [];
  List<Widget> _viewBox = [];

  setAllCourses(List courses) {
    _allCourses = courses;
    notifyListeners();
  }

  setCourseViewBox(List<Widget> viewBox) {
    _viewBox = viewBox;
    notifyListeners();
  }

  setAllCategories(List categories) {
    _allCategories = categories;
    notifyListeners();
  }

  setAllSubCategories(List subCategories) {
    _allsubCategories = subCategories;
    notifyListeners();
  }

  setCourseData(List data) {
    _addData = data;
    notifyListeners();
  }

  UnmodifiableListView get courses => UnmodifiableListView(_allCourses);
  UnmodifiableListView get categories => UnmodifiableListView(_allCategories);
  UnmodifiableListView get subCategories =>
      UnmodifiableListView(_allsubCategories);
  UnmodifiableListView get course_data => UnmodifiableListView(_addData);
  UnmodifiableListView<Widget> get view_box_list =>
      UnmodifiableListView(_viewBox);
}
