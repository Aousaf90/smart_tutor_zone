import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import './AuthenticationPage/Register.dart';
import './helperFunction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Course(),
        ),
        ChangeNotifierProvider(create: (context) => StudentModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 247, 245, 245),
        ),
        title: 'Main Page',
        home: _isLoggedIn ? const homePage() : const RegisterPage(),
        // home: Text("Login Status $_isLoggedIn"),
      ),
    );
  }

  void isLoggedIn() {
    bool loginStatus = false;
    helperFunction.getloginStatus().then((value) {
      setState(() {
        if (value != null) {
          _isLoggedIn = value;
        }
      });
    });
  }
}
