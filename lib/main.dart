import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/firebase_options.dart';
import 'package:tutor_connect/pages/auth_page.dart';
import 'package:tutor_connect/pages/builder_pages/student_builder_page.dart';
import 'package:tutor_connect/pages/builder_pages/tutor_builder_page.dart';
import 'package:tutor_connect/pages/home_page.dart';

Future<void> main() async {
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
      routes: {
        '/homepage': (context) => const HomePage(),
        '/tutor_builder': (context) => TutorBuilderPage(),
        '/student_builder': (context) => StudentBuilderPage(),
      },
    );
  }
}
