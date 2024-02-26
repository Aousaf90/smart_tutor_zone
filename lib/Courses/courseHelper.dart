import 'package:cloud_firestore/cloud_firestore.dart';

List allCategories = [];

Future<List<String>> getAllCategories() async {
  List<String> categories = [];

  try {
    CollectionReference courseCategoriesCollection =
        FirebaseFirestore.instance.collection("Courses_Categories");
    QuerySnapshot querySnapshot = await courseCategoriesCollection.get();
    for (var doc in querySnapshot.docs) {
      categories.add(doc.id);
    }
  } catch (e) {
    print('Error getting categories: $e');
  }

  return categories;
}
