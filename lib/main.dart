import 'package:dar_elkahrba/providers/course.dart';
import 'package:dar_elkahrba/screens/add_new_course_screen.dart';
import 'package:dar_elkahrba/screens/courses_overview_screen.dart';
import 'package:dar_elkahrba/screens/home_screen.dart';
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
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(240, 244, 249, 1),
            primaryColor: Colors.white,
            accentColor: Colors.black),
        home: HomeScreen(),
        routes: {
          AddNewCourseScreen.routeName: (context) => AddNewCourseScreen(),
          CoursesOverviewScreen.routeName: (context) => CoursesOverviewScreen(),
        },
      ),
    );
  }
}
