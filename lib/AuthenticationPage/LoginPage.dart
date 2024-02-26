import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_tutor_zone/AuthenticationPage/Register.dart';
import 'package:smart_tutor_zone/AuthenticationPage/recoverPassword.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String studentEmail = "";
  String studentPassword = "";
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Scrollable(
          viewportBuilder: (context, position) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    height: 300,
                    width: 400,
                    child: Expanded(
                      flex: 8,
                      child: SvgPicture.asset("images/login.svg",
                          fit: BoxFit.contain),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Let's Sign In.!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Login to Your Account to Continue your Courses",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  //Text Form Field for  Input and Validation
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email Form Field
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration:
                                  WidgetStyle().textInputDecorator.copyWith(
                                        hintText: "Email",
                                      ),
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return "Email should not be empty";
                                }
                                // Add additional email validation if needed
                                return null;
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  studentEmail = newValue.toString();
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          // Password Form Field
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration:
                                  WidgetStyle().textInputDecorator.copyWith(
                                        prefixIcon: Icon(Icons.lock),
                                        hintText: "Password",
                                      ),
                              obscureText: true, // Hide the password text
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return "Password should not be empty";
                                }
                                // Additional validation logic for password if needed
                                return null;
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  studentPassword = newValue.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember Me Area
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(
                                  () {
                                    rememberMe = !rememberMe;
                                  },
                                );
                              },
                            ),
                            const Text("Remember Me")
                          ],
                        ),
                        TextButton(
                          onPressed: recoverPassword,
                          child: const Text("Forget Password ?"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child: ElevatedButton(
                      style: WidgetStyle().buttonStyle,
                      onPressed: loginUser,
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an Account? ",
                        children: [
                          TextSpan(
                            text: "SIGN Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 5, 71, 125)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WidgetStyle().NextScreen(
                                  context,
                                  RegisterPage(),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  loginUser() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
      final _auth = FirebaseAuth.instance;
      final _cloud_firestore = FirebaseFirestore.instance;
      try {
        final user_Credential = await _auth.signInWithEmailAndPassword(
            email: studentEmail, password: studentPassword);
        final studentModel = Student();
        if (user_Credential != null) {
          if (rememberMe) {
            helperFunction.saveStudentEmail(studentEmail);
            await _cloud_firestore
                .collection("Students")
                .where('email', isEqualTo: studentEmail)
                .get()
                .then((value) {
              value.docs.forEach((element) {
                setState(() {
                  studentModel.setStudentData(
                    uid: _auth.currentUser!.uid,
                    student_name: element['name'],
                    student_education: element['email'],
                    student_email: studentEmail,
                    student_phoneNumber: element['phoneNumber'],
                  );
                  // Print values of each field fetched from Firestore
                  print("Name: ${element['name']}");
                  print("Email: ${element['email']}");
                  print("Phone Number: ${element['phoneNumber']}");
                });
              });
              helperFunction.saveUserLogInStatus(true);
              // Stop the loading indicator
              Navigator.of(context).pop();
              // Navigate to the next screen after fetching and setting data
              WidgetStyle().NextScreen(
                context,
                homePage(),
              );
            }).catchError((error) {
              // Show error in Snackbar and stop loading
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error fetching user data: $error"),
                ),
              );
              Navigator.of(context).pop();
            });
          }
        }
      } on FirebaseAuthException catch (e) {
        // Show error in Snackbar and stop loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Firebase Authentication Error: ${e.message}"),
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  recoverPassword() {
    WidgetStyle().NextScreen(
      context,
      RecoverPassowrdPage(),
    );
  }
}
