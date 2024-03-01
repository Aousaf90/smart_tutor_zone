import 'package:cloud_firestore/cloud_firestore.dart';

List<String> mainCategoriesList = [];
Map<String, List<dynamic>> courseCollection = {};

Future<void> getAllCategories() async {
  List<String> categories = [];

  try {
    CollectionReference mainCategoriesCollection =
        FirebaseFirestore.instance.collection("Courses_Categories");

    QuerySnapshot querySnapshot = await mainCategoriesCollection.get();
    mainCategoriesList = querySnapshot.docs.map((docs) => docs.id).toList();

    for (var mainCategory in mainCategoriesList) {
      DocumentReference documentRef =
          mainCategoriesCollection.doc(mainCategory);

      documentRef.get().then(
        (querySnapshot) {
          final data = querySnapshot.data() as Map<String, dynamic>;
          List subCategoryNames = data['subCategories'];
          for (var subCategory in subCategoryNames) {
            documentRef.collection(subCategory).get().then(
              (subQuerySnapshot) {
                subQuerySnapshot.docs.forEach(
                  (doc) {
                    print("${mainCategory} = ${subCategory} = ${doc.id}");
                  },
                );
              },
            );
          }
        },
      );
    }
  } catch (e) {
    print('Error getting categories: $e');
  }
}
