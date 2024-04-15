import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Models/enrollStudents.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:smart_tutor_zone/style.dart';

class CardPayment extends StatefulWidget {
  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  final _globalKey = GlobalKey<FormState>();

  TextStyle cardTextStyle = TextStyle(
    color: Colors.white,
  );
  String card_holder_name = "Card Number";
  String card_number = "Holder Name";
  String expiration_date = "MM/YY";
  String security_code = "CVV";
  @override
  Widget build(BuildContext context) {
    return Consumer<Course>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Card Details",
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: 350,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage("images/credit_card_texture.jpg"),
                          opacity: 0.9,
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          card_number,
                          style: cardTextStyle,
                        ),
                        const SizedBox(height: 50),
                        Text(
                          card_holder_name,
                          style: cardTextStyle,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              expiration_date,
                              style: cardTextStyle,
                            ),
                            const SizedBox(width: 70),
                            Text(
                              security_code,
                              style: cardTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Form(
                      key: _globalKey,
                      child: Column(
                        children: [
                          CardDetailListTile(
                            required_field: "Card Number",
                            validationCallBack: (value) {
                              if (RegExp(r'^.*[a-zA-Z].*$').hasMatch(value!) &&
                                      value.length < 16 ||
                                  value.length > 16) {
                                return "Invalid Card Number";
                              } else {
                                return null;
                              }
                            },
                            onChangedCallBack: (value) {
                              setState(
                                () {
                                  card_number = value;
                                },
                              );
                            },
                          ),
                          CardDetailListTile(
                            required_field: "Name",
                            validationCallBack: (value) {
                              if (value!.isEmpty == true) {
                                return "Field Can Not be Empty";
                              }
                            },
                            onChangedCallBack: (value) {
                              setState(
                                () {
                                  value = value.toUpperCase();
                                  card_holder_name = value;
                                },
                              );
                            },
                          ),
                          CardDetailListTile(
                            required_field: "Expiration Date",
                            validationCallBack: (value) {
                              if (RegExp(r'^.*[a-zA-Z].*$').hasMatch(value!) &&
                                      value.length < 4 ||
                                  value.length > 4) {
                                return "Invalid Card Number";
                              } else {
                                return null;
                              }
                            },
                            onChangedCallBack: (value) {
                              setState(
                                () {
                                  String slash = "/";
                                  if (value.length == 2) {
                                    expiration_date = value + slash;
                                  } else if (value.length > 2) {
                                    expiration_date = value.substring(0, 2) +
                                        slash +
                                        value.substring(2);
                                  } else {
                                    expiration_date = value;
                                  }
                                },
                              );
                            },
                          ),
                          CardDetailListTile(
                            required_field: "Security Code",
                            validationCallBack: (value) {
                              if (RegExp(r'^.*[a-zA-Z].*$').hasMatch(value!) &&
                                      value.length < 3 ||
                                  value.length > 3) {
                                return "Invalid Security code";
                              }
                            },
                            onChangedCallBack: (value) {
                              setState(
                                () {
                                  security_code = value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff005af5),
                    ),
                    width: 350,
                    child: TextButton(
                      onPressed: () async {
                        String student_email =
                            await helperFunction.getStudentEmail() ?? "";
                        print("Student Email = ${student_email}");
                        setEnrollmentData(
                          student_email,
                          value.selectedCourseDetail['name'],
                          value.selectedCourseDetail['category'],
                          value.selectedCourseDetail['subCategory'],
                        );
                        enrollStudent(context);
                      },
                      child: Text(
                        "Pay Amount",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CardDetailListTile extends StatelessWidget {
  String required_field;
  void Function(String)? onChangedCallBack;
  String? Function(String?)? validationCallBack;
  CardDetailListTile(
      {required this.required_field,
      required this.onChangedCallBack,
      required this.validationCallBack});
  @override
  Widget build(
    BuildContext context,
  ) {
    return ListTile(
      leading: Container(
        width: 130,
        child: Text(
          required_field,
          style: TextStyle(fontSize: 18),
        ),
      ),
      title: Container(
        child: TextFormField(
          decoration: InputDecoration(hintText: "Required"),
          validator: validationCallBack,
          onChanged: onChangedCallBack,
        ),
      ),
    );
  }

  payAmount() {}
}
