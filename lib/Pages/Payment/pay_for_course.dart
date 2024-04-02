import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Payment/payment_with_card.dart';

class CoursePayment extends StatefulWidget {
  @override
  State<CoursePayment> createState() => _CoursePaymentState();
}

bool google_checkbox = false;
bool card_checkbox = false;

class _CoursePaymentState extends State<CoursePayment> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Course>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Color(0xfff5f9ff),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Container(
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        weight: 40,
                      ),
                    ),
                    title: const Text(
                      "Payment Methods",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 70,
                                width: 70,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.selectedCourseDetail['subCategory'],
                                      style: TextStyle(
                                        color: Color(0xffff7c25),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "${value.selectedCourseDetail['name']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Select the Payment Methods you Want to Use",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GooglePayContainer(
                              is_checked: google_checkbox,
                              change_value: (value) {
                                setState(() {
                                  if (card_checkbox == true) {
                                    card_checkbox = !card_checkbox;
                                  }
                                  google_checkbox = value!;
                                });
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            PayWithDebitCardContainer(
                              is_checked: card_checkbox,
                              change_value: (value) {
                                if (google_checkbox == true) {
                                  google_checkbox = !google_checkbox;
                                }
                                setState(() {
                                  card_checkbox = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 90),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff005af5),
                      ),
                      onPressed: () {
                        card_checkbox
                            ? payWithCard(context)
                            : payWithGooglePay();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Enroll Course ${value.selectedCourseDetail['price']} /-",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(width: 20),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  payWithCard(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardPayment(),
      ),
    );
  }

  payWithGooglePay() {
    print("Pay with G Pay");
  }
}

class PayWithDebitCardContainer extends StatelessWidget {
  bool is_checked;
  void Function(bool?)? change_value;
  PayWithDebitCardContainer(
      {required this.is_checked, required this.change_value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Pay With Credit Card/ Debit Card",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Checkbox(
            value: is_checked,
            onChanged: change_value,
          ),
        ],
      ),
    );
  }
}

class GooglePayContainer extends StatelessWidget {
  bool is_checked = false;
  void Function(bool?)? change_value;
  GooglePayContainer({required this.is_checked, required this.change_value});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Google Pay",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Checkbox(
            value: is_checked,
            onChanged: change_value,
          ),
        ],
      ),
    );
  }
}
