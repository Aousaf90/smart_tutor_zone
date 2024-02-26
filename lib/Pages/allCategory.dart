import 'package:flutter/material.dart';

import '../style.dart';

class allCatagories extends StatefulWidget {
  const allCatagories({super.key});

  @override
  State<allCatagories> createState() => _allCatagoriesState();
}

class _allCatagoriesState extends State<allCatagories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Category",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            //Container 1 (Search Bar)
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(31, 148, 149, 173),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: WidgetStyle().textInputDecorator.copyWith(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search For",
                      suffixIcon: const Icon(
                        Icons.filter_1_outlined,
                        color: Colors.black,
                      ),
                    ),
              ),
            ),
            //Contaner 2 (Categoryes)
            Container(child: categoryCatalog()),
          ],
        ),
      ),
    );
  }

  Widget categoryCatalog() {
    // Function to build a row item with icon and text
    Widget buildRowItem(
        IconData iconData1, String label1, IconData iconData2, String label2) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: Column(
                children: [
                  Icon(iconData1, size: 50),
                  Text(label1),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Column(
                children: [
                  Icon(iconData2, size: 50),
                  Text(label2),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRowItem(
              Icons.abc, "Container 1", Icons.access_alarm, "Container 2"),
          buildRowItem(Icons.safety_check, "Container 3", Icons.lock_clock,
              "Container 4"),
          buildRowItem(
              Icons.search, "Container 5", Icons.delete, "Container 6"),
          buildRowItem(Icons.arrow_back, "Container 7", Icons.arrow_forward,
              "Container 8"),
        ],
      ),
    );
  }
}
