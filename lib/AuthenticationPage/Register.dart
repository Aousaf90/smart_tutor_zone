import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/AuthenticationPage/LoginPage.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import '../style.dart';
import 'package:lottie/lottie.dart';
import '../firebaseModels.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

String studentEmail = "";
String studentName = "";
String studentPhNumber = "";
String studentEducation = "";
String studentPassword = "";

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
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
                      child: LottieBuilder.network(
                        'https://assets1.lottiefiles.com/packages/lf20_wWZd8QJ7Cj.json',
                      )),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Getting Started.!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Create an Account to Continue  your all Courses",
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
                          // Name Form Field
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration: WidgetStyle()
                                  .textInputDecorator
                                  .copyWith(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Full Name"),
                              validator: (value) {
                                if (value!.isEmpty || value!.length <= 1) {
                                  return "Name should not be empty";
                                }
                                // Additional validation logic for name if needed
                                return null;
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  studentName = newValue.toString();
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          // Education Form Field
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration:
                                  WidgetStyle().textInputDecorator.copyWith(
                                        prefixIcon: Icon(Icons.school),
                                        hintText: "Chose Your Education",
                                      ),
                              validator: (value) {
                                if (value!.isEmpty || value == null) {
                                  return "Education should not be empty";
                                }
                                // Additional validation logic for education if needed
                                return null;
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  studentEducation = newValue.toString();
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
                    child: Text("Terms and Conditions"),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 130, vertical: 20)),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromARGB(255, 41, 65, 202)),
                        ),
                        onPressed: signUp,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account ? ",
                        children: [
                          TextSpan(
                            text: "SIGN IN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 5, 71, 125)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WidgetStyle().NextScreen(
                                  context,
                                  LoginPage(),
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

  // List textFormField({name = "", icon = Widget}) {
  //   Widget textFormField = TextFormField(
  //     validator: (value) {
  //       if (value!.length > 0) {
  //         null;
  //       } else {}
  //     },
  //   );
  //   return [1, textFormField];
  // }
  signUp() async {
    final _auth = FirebaseAuth.instance;
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
      try {
        _auth
            .createUserWithEmailAndPassword(
                email: studentEmail, password: studentPassword)
            .then(
          (value) {
            if (value != null) {
              setState(() {
                helperFunction.saveStudentEmail(studentEmail);
                helperFunction.saveUserLogInStatus(true);
              });
              WidgetStyle().NextScreen(
                context,
                homePage(),
              );
            }
          },
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error Saving User Data"),
          ),
        );
      }
    }
  }
}
