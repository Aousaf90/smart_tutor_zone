import 'package:cloud_firestore/cloud_firestore.dart';

List mainCategory = [];
getMainCategories() {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("Courses_Categories");

  collectionRef.get().then(
    (value) {
      value.docs.forEach(
        (element) {
          mainCategory.add(element.id);
        },
      );
    },
  );
  Set<dynamic> allCategories = mainCategory.toSet();
  return allCategories;
}

Future<dynamic> getSubCategories(document_name) async {
  try {
    List sub_categories = [];
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Courses_Categories");

    final DocumentSnapshot snapshot =
        await collectionRef.doc(document_name).get();

    if (snapshot.exists) {
      Map<String, dynamic> Document_Value =
          snapshot.data() as Map<String, dynamic>;
    } else {
      print("Document does not exist");
    }
    return snapshot['subCategories'];
  } catch (e) {
    print(
      "${e.toString()}",
    );
  }
}

Future<Map<String, dynamic>> getCourse(mainDocName, DocName) async {
  final Map<String, dynamic> sub_Category_List = {};
  List<dynamic> course_list = [];
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("/Courses_Categories/$mainDocName/$DocName");
  await collectionReference.get().then(
    (value) {
      value.docs.forEach(
        (element) {
          course_list.add(element.id);
        },
      );
    },
  );
  sub_Category_List[DocName] = course_list;
  return sub_Category_List;
}

getAllCategories() async {
  Map<String, dynamic> course_detail = {};
  List main_categories = await getMainCategories().toList();
  for (var categorie in main_categories) {
    List sub_courses_list = [];
    List subCategories = await getSubCategories(categorie);
    for (var subCategor in subCategories) {
      Map<String, dynamic> courses = await getCourse(categorie, subCategor);
      sub_courses_list.add(courses);
    }
    course_detail[categorie] = sub_courses_list;
  }
  print(course_detail['Technology'][0]);
}
