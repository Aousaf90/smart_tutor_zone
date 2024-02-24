import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_tutor_zone/AuthenticationPage/Register.dart';
import 'package:smart_tutor_zone/AuthenticationPage/recoverPassword.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
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
                    child: LottieBuilder.network(
                        'https://assets3.lottiefiles.com/packages/lf20_MbephoYReu.json'),
                    height: 300,
                    width: 300,
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

  loginUser() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
      final _auth = FirebaseAuth.instance;
      try {
        final user_Credential = _auth.signInWithEmailAndPassword(
            email: studentEmail, password: studentPassword);

        if (user_Credential != null) {
          if (rememberMe) {
            helperFunction.saveStudentEmail(studentEmail);
            helperFunction.saveUserLogInStatus(true);
          }
          WidgetStyle().NextScreen(
            context,
            homePage(),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error Saving User Data"),
          ),
        );
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
