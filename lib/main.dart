import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/pages/chat_page.dart';
import 'package:tutor_connect/services/auth/auth.dart';
import 'package:tutor_connect/services/auth/login_or_register.dart';
import 'package:tutor_connect/firebase_options.dart';
import 'package:tutor_connect/pages/home_page.dart';
import 'package:tutor_connect/pages/login_page.dart';
import 'package:tutor_connect/pages/profile_page.dart';
import 'package:tutor_connect/pages/students_page.dart';
import 'package:tutor_connect/pages/profile_page.dart';
import 'package:tutor_connect/pages/tutors_page.dart';
import 'package:tutor_connect/theme/dark_mode.dart';
import 'package:tutor_connect/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_or_register_page': (context) => LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/students_page': (context) => StudentsPage(),
        '/tutors_page': (context) => TutorsPage(),
      },
    );
  }
}
