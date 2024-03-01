import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/AuthenticationPage/Register.dart';
import 'package:smart_tutor_zone/AuthenticationPage/recoverPassword.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LottieBuilder.network(
                      "https://assets1.lottiefiles.com/packages/lf20_wWZd8QJ7Cj.json"),
                  Container(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's Sign In.!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                if (value!.isEmpty) {
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
                          const SizedBox(height: 20),
                          // Password Form Field
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration:
                                  WidgetStyle().textInputDecorator.copyWith(
                                        prefixIcon: const Icon(Icons.lock),
                                        hintText: "Password",
                                      ),
                              obscureText: true, // Hide the password text
                              validator: (value) {
                                if (value!.isEmpty) {
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
                      child: const Text(
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
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an Account? ",
                        children: [
                          TextSpan(
                            text: "SIGN Up",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 5, 71, 125)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WidgetStyle().NextScreen(
                                  context,
                                  const RegisterPage(),
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
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      final auth = FirebaseAuth.instance;
      final cloudFirestore = FirebaseFirestore.instance;
      try {
        final userCredential = await auth.signInWithEmailAndPassword(
            email: studentEmail, password: studentPassword);
        final studentModel = Student();
        if (rememberMe) {
          helperFunction.saveStudentEmail(studentEmail);
          helperFunction.saveUserLogInStatus(true);
        }
        await cloudFirestore
            .collection("Students")
            .where('email', isEqualTo: studentEmail)
            .get()
            .then(
          (value) {
            value.docs.forEach(
              (element) {
                setState(
                  () {
                    helperFunction.saveStudentName(element['name']);
                    helperFunction.saveStudentEducation(element['Education']);
                    helperFunction.savePhoneNumber(element['phoneNumber']);
                  },
                );
                print(
                    "Student Name In Login Page= ${studentModel.getStudentName()}");
              },
            );
            Navigator.of(context).pop();
            WidgetStyle().NextScreen(
              context,
              const homePage(),
            );
          },
        ).catchError(
          (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error fetching user data: $error"),
              ),
            );
            Navigator.of(context).pop();
          },
        );
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
      const RecoverPassowrdPage(),
    );
  }
}
