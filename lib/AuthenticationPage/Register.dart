import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/AuthenticationPage/LoginPage.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/Pages/bottom_navigator_page.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import './userModel.dart';
import '../style.dart';
import 'package:lottie/lottie.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LottieBuilder.network(
                    "https://assets3.lottiefiles.com/packages/lf20_MbephoYReu.json",
                    height: 300,
                    width: 300,
                  ),
                  Container(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Getting Started.!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Create an Account to Continue  your all Courses",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          // Name Form Field
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration: WidgetStyle()
                                  .textInputDecorator
                                  .copyWith(
                                      prefixIcon: const Icon(Icons.person),
                                      hintText: "Full Name"),
                              validator: (value) {
                                if (value!.isEmpty || value.length <= 1) {
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
                          const SizedBox(height: 10),
                          // Education Form Field
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              decoration:
                                  WidgetStyle().textInputDecorator.copyWith(
                                        prefixIcon: const Icon(Icons.school),
                                        hintText: "Chose Your Education",
                                      ),
                              validator: (value) {
                                if (value!.isEmpty) {
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
                          const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  Container(
                    child: const Text("Terms and Conditions"),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 130, vertical: 20)),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(255, 41, 65, 202)),
                        ),
                        onPressed: signUp,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account ? ",
                        children: [
                          TextSpan(
                            text: "SIGN IN",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 5, 71, 125)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                WidgetStyle().NextScreen(
                                  context,
                                  const LoginPage(),
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
  Future<void> signUp() async {
    final auth = FirebaseAuth.instance;
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      try {
        final userCredential = await auth.createUserWithEmailAndPassword(
            email: studentEmail, password: studentPassword);
        final uid = userCredential.user!.uid;
        if (userCredential.user != null) {
          print("Student Name = ${studentName}");
          print("Student Email = ${studentEmail}");
          final studentModel = Student();
          studentModel.createStudentEntity(
            student_email: studentEmail,
            student_PhoneNumber: "03061310090",
            student_name: studentName,
            student_Education: studentEducation,
            uid: uid,
          );
          helperFunction.saveStudentEmail(studentEmail);
          helperFunction.saveUserLogInStatus(true);
          helperFunction.saveStudentName(studentName);
          helperFunction.saveStudentEducation(studentEducation);
          helperFunction.savePhoneNumber("03061310090");
          helperFunction.saveCourseEnrolled([]);
          Provider.of<StudentModel>(context, listen: false).setData(
              studentEducation,
              studentEmail,
              studentName,
              "03061310090",
              uid, []);
          showDialog(
            barrierColor: Colors.white,
            context: context,
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  title: Image(
                    image: AssetImage("images/person_congrats.png"),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Congratulations",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: AutofillHints.countryName),
                      ),
                      const Text(
                        "Your Account is  Ready to Use. You will be redirected to the Home Page in a few seconds,",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        softWrap: true,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            },
          );
          Future.delayed(const Duration(seconds: 3), () {
            WidgetStyle().NextScreen(
              context,
              const PageNavigator(),
            );
          });
          WidgetStyle().NextScreen(context, const homePage());
        }
      } on FirebaseAuthException catch (e) {
        // Dismiss the dialog
        Navigator.of(context).pop();
        print("Error = ${e.message}");
        // Show the specific error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Saving User Data: ${e.message}"),
          ),
        );
      }
    }
  }
}
