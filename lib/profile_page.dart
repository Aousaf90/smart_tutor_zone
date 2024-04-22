import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/helperFunction.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/Blue Bubble Vector Background.jpg"),
            opacity: 0.2),
      ),
      child: Scaffold(
          backgroundColor: Color(0xfff5f9ff),
          appBar: AppBar(
            backgroundColor: Color(0xfff5f9ff),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: const Text("Profile"),
          ),
          body: Consumer<StudentModel>(
            builder: (context, value, child) {
              List course_catalog = value.course_detail;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                      ),
                      DataField(
                        value: value.name_detail[0],
                        icon: Icon(Icons.person),
                        field_type: "name",
                      ),
                      DataField(
                        value: value.email_detail[0],
                        icon: Icon(Icons.email),
                        field_type: "email",
                      ),
                      DataField(
                        value: value.education_detail[0],
                        icon: Icon(Icons.school),
                        field_type: "education",
                      ),
                      DataField(
                        value: value.phone_number[0],
                        icon: Icon(Icons.phone),
                        field_type: "phone",
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            Student().logout(context);
                          },
                          child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              color: Color(0xff005af5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ListTile(
                              leading: SizedBox(
                                width: 70,
                              ),
                              title: const Text(
                                "LOG OUT",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                          height: 300,
                          child: Column(
                            children: [
                              const Text("My Courses",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              Divider(),
                              Container(
                                  height: 100,
                                  child: ListView.builder(
                                    itemCount: course_catalog.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: ListTile(
                                          leading: Text("${index + 1}",
                                              style: TextStyle(fontSize: 20)),
                                          title: Text(
                                            "${course_catalog[index]['name']}",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ))
                            ],
                          )),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}

class DataField extends StatelessWidget {
  String value;
  Icon icon;
  String field_type;
  DataField(
      {required this.value, required this.icon, required this.field_type});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            onTap: () {
              updateFieldData(context, value, field_type);
            },
            leading: icon,
            title: Text(value),
            trailing: Icon(
              Icons.edit,
            ),
          ),
        ),
      ],
    );
  }

  updateFieldData(context, field, String field_type) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return UpdateField(
          field: field,
          field_type: field_type,
        );
      },
    );
  }
}

class UpdateField extends StatefulWidget {
  UpdateField({required this.field, required this.field_type});
  String field_type;
  String field;

  @override
  State<UpdateField> createState() => _UpdateFieldState();
}

class _UpdateFieldState extends State<UpdateField> {
  String to_change_value = "";

  String change_data = "";

  @override
  Widget build(BuildContext context) {
    switch (widget.field_type) {
      case ("name"):
        to_change_value = widget.field_type;
        break;
      case ("education"):
        to_change_value = widget.field_type;
        break;
      case ("email"):
        to_change_value = widget.field_type;
        break;
      case ("phone"):
        to_change_value = widget.field_type;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 800,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Smart Tutor Zone ",
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: AutofillHints.countryName,
                  color: Color(0xffFF9C12)),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Previous ${to_change_value}: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                  TextSpan(
                    text: widget.field,
                    style: TextStyle(
                        color: Color(0xffFF9C12),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                hintText: "Enter new ${to_change_value}",
                hintStyle: const TextStyle(
                    color: Color(0xffFF9C12),
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
              onChanged: (value) {
                setState(() {
                  change_data = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                hintText: "Re-enter your ${to_change_value}",
                hintStyle: const TextStyle(
                    color: Color(0xffFF9C12),
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
              validator: (value) {
                if (value != change_data) {
                  return "Please Enter same ${to_change_value} as above";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  await updateValue(widget.field, change_data, to_change_value);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Color(0xff005af5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    leading: SizedBox(
                      width: 70,
                    ),
                    title: const Text(
                      "Update Value",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateValue(String field, String new_value, String to_change_field) async {
    String uid =
        Provider.of<StudentModel>(context, listen: false).uid_detail[0];

    if (to_change_value == 'email') {
      await updateEmail(uid, new_value);
    } else if (to_change_value == "education") {
      await updateEducation(uid, new_value);
    } else if (to_change_value == "name") {
      await updateName(uid, new_value);
    } else if (to_change_value == "phone") {
      await updatePhoneNumber(uid, new_value);
    }
  }

  Future updateEmail(String uid, String email) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.doc("Students/${uid}");
      await documentReference.update({"email": email}).then((value) {
        Provider.of<StudentModel>(context, listen: false).updateEmail(email);
        helperFunction.saveStudentEmail(email);
      });
    } catch (e) {
      print("Error in updateEmail function : $e");
    }
  }

  Future updateEducation(String uid, String education) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.doc("Students/${uid}");
      await documentReference.update({"Education": education}).then((value) {
        Provider.of<StudentModel>(context, listen: false)
            .updateEducation(education);
        helperFunction.saveStudentEducation(education);
      });
    } catch (e) {
      print("Erro in Update Education : $e");
    }
  }

  Future updateName(String uid, String name) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.doc("Students/${uid}");
      await documentReference.update({"name": name}).then((value) {
        Provider.of<StudentModel>(context, listen: false).updateName(name);
        helperFunction.saveStudentName(name);
      });
    } catch (e) {
      print("Error in updateName: $e");
    }
  }

  Future updatePhoneNumber(String uid, String phone_number) async {
    try {
      print("New Number in profile page= ${phone_number}");
      DocumentReference documentReference =
          FirebaseFirestore.instance.doc("/Students/${uid}");
      print("Docuemnt ref = ${documentReference}");
      await documentReference
          .update({"phoneNumber": phone_number}).then((value) {
        print("Phoen Number updated successfully");
        Provider.of<StudentModel>(context, listen: false)
            .updatePhoneNumber(phone_number);
        helperFunction.savePhoneNumber(phone_number);
      });
    } catch (e) {
      print("Error in updatePhoneNumber : $e");
    }
  }
}
