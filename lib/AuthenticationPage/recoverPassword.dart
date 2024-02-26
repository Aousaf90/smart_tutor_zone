import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_tutor_zone/style.dart';

class RecoverPassowrdPage extends StatefulWidget {
  const RecoverPassowrdPage({super.key});

  @override
  State<RecoverPassowrdPage> createState() => _RecoverPassowrdPageState();
}

class _RecoverPassowrdPageState extends State<RecoverPassowrdPage> {
  final _formKey = GlobalKey<FormState>();
  String userEmail = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          iconSize: 40,
        ),
        bottomOpacity: 20,
        title: const Text(
          "Forgot Password",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email should not be empty";
                    }
                    // Add additional email validation if needed
                    return null;
                  },
                  onSaved: (newValue) {
                    setState(() {
                      userEmail = newValue.toString();
                    });
                  },
                  decoration: WidgetStyle().textInputDecorator,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextFormField(
                      onSaved: (newValue) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextFormField(
                      onSaved: (newValue) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextFormField(
                      onSaved: (newValue) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextFormField(
                      onSaved: (newValue) {},
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              child: ElevatedButton(
                style: WidgetStyle().buttonStyle.copyWith(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                    ),
                onPressed: recoverPassword,
                child: const Text(
                  "Recover Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future recoverPassword() async {
    if (_formKey.currentState!.validate()) {
      final auth = FirebaseAuth.instance;
      try {
        await auth.sendPasswordResetEmail(email: userEmail).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Varification Email Send Successfully"),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        String errorMessage = e.message ?? "Unknows error occured";
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }
  }
}
