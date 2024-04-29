import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/AuthenticationPage/Register.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/Pages/bottom_navigator_page.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:lottie/lottie.dart';

import '../style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool visible_password = true;
  String studentEmail = "";
  String studentPassword = "";
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 249, 255, 1),
      body: SingleChildScrollView(
        child: Scrollable(
          viewportBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: LottieBuilder.network(
                      "https://assets1.lottiefiles.com/packages/lf20_wWZd8QJ7Cj.json",
                      backgroundLoading: true,
                    ),
                  ),
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
                              decoration: WidgetStyle()
                                  .textInputDecorator
                                  .copyWith(
                                    prefixIcon: const Icon(Icons.lock),
                                    hintText: "Password",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          visible_password = !visible_password;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.password_rounded,
                                      ),
                                    ),
                                  ),
                              obscureText:
                                  visible_password, // Hide the password text
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
                              obscuringCharacter: "*",
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
                        forgetPasswordButton(),
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
            .doc(userCredential.user!.uid)
            .get()
            .then(
          (value) {
            Map<String, dynamic> element = value.data() ?? {};
            StudentModel sm = StudentModel();
            String name = element['name'];
            String education = element['Education'];
            String phone_number = element['phoneNumber'];
            String uid = element['uid'];
            List<dynamic> courses = element['Courses'];
            setState(
              () {
                helperFunction.saveStudentName(name);
                helperFunction.saveStudentEducation(education);
                helperFunction.savePhoneNumber(phone_number);
                Provider.of<StudentModel>(context, listen: false).setData(
                    education, studentEmail, name, phone_number, uid, courses);
              },
            );
          },
        );
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

  showAlertBox() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("AlertDialog Title"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Text("This is a demo alert dialog"),
                Text("Would you like to approve of this message? "),
              ],
            ),
          ),
        );
      },
    );
  }
}

class forgetPasswordButton extends StatefulWidget {
  @override
  State<forgetPasswordButton> createState() => _forgetPasswordButtonState();
}

class _forgetPasswordButtonState extends State<forgetPasswordButton> {
  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  TextEditingController textEditingController = TextEditingController();
  String email = "";
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(30),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: textEditingController,
                        decoration:
                            InputDecoration(hintText: "Enter your Email,"),
                        onChanged: (value) {
                          setState(() {
                            email = value.toString();
                          });
                        },
                      ),
                      TextButton(
                        onPressed: recoverPassword,
                        child: Text("Recover Password",
                            style: TextStyle(fontSize: 18, color: Colors.blue)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Go Back",
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Text("Forget Password ?"),
    );
  }

  recoverPassword() {
    final auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: email).then((value) {
      showBottomSheet(
        context: context,
        builder: (context) {
          return Text("Reset Link has been send to your Email");
        },
      );
    });
  }
}
