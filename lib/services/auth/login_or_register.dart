import 'package:flutter/material.dart';
import 'package:tutor_connect/pages/login_page.dart';
import 'package:tutor_connect/pages/student_register_page.dart';
import 'package:tutor_connect/pages/tutor_register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show login page
  bool showLoginPage = true;
  bool showTutorRegisterPage = false;
  bool showStudentRegisterPage = false;

  // toggle between the pages
  void studentRegister() {
    setState(() {
      showLoginPage = false;
      showTutorRegisterPage = false;
      showStudentRegisterPage = true;
    });
  }

  void tutorRegister() {
    setState(() {
      showLoginPage = false;
      showTutorRegisterPage = true;
      showStudentRegisterPage = false;
    });
  }

  void login() {
    setState(() {
      showLoginPage = true;
      showTutorRegisterPage = false;
      showStudentRegisterPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
          studentRegister: studentRegister, tutorRegister: tutorRegister);
    } else if (showTutorRegisterPage) {
      return TutorRegisterPage(login: login, studentRegister: studentRegister);
    } else {
      return StudentRegisterPage(login: login, tutorRegister: tutorRegister);
    }
  }
}
