import 'package:dar_elkahrba/SplashScreen.dart';
import 'package:dar_elkahrba/providers/course.dart';
import 'package:dar_elkahrba/providers/modelHud.dart';
import 'package:dar_elkahrba/screens/course/OldSessions.dart';
import 'package:dar_elkahrba/screens/verify_screen.dart';
import 'package:dar_elkahrba/screens/course/add_new_course_screen.dart';
import 'package:dar_elkahrba/screens/authentication/login_screen.dart';
import 'package:dar_elkahrba/screens/course/courses_overview_screen.dart';
import 'package:dar_elkahrba/screens/home_screen.dart';
import 'package:dar_elkahrba/screens/qr/sessions.dart';
import 'package:dar_elkahrba/screens/student_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CoursesProvider(),
        ),
        ChangeNotifierProvider<modelHud>(
          create: (context) => modelHud(),
        )
      ],
      child: MaterialApp(
        title: 'Dar Elkahrba',
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(240, 244, 249, 1),
            primaryColor: Colors.white,
            accentColor: Colors.black),
        home: SplashScreen(),
        routes: {
          HomeScreen.routeName: (context)=> HomeScreen(),
          AddNewCourseScreen.routeName: (context) => AddNewCourseScreen(),
          CoursesOverviewScreen.routeName: (context) => CoursesOverviewScreen(),
          VerifiedScreen.routeName: (context) => VerifiedScreen(),
          StudentScreen.routeName: (context) => StudentScreen(),
        },
      ),
    );
  }
}
