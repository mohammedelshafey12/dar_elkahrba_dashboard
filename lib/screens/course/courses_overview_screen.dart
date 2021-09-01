import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/providers/course.dart';
import 'package:dar_elkahrba/screens/course/OldSessions.dart';
import 'package:dar_elkahrba/screens/course/add_new_course_screen.dart';
import 'package:dar_elkahrba/screens/course/course_student.dart';
import 'package:dar_elkahrba/widgets/app_drawer.dart';
import 'package:dar_elkahrba/widgets/course_dialog_item.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_verify_student.dart';

class CoursesOverviewScreen extends StatelessWidget {
  static const routeName = '/courses-overview';
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: stream(context),
      drawer: AppDrawer(),
    );
  }

  Widget stream(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('CourseCollection').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var courseData = snapshot.data!.docs[index];
              return Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Course Sessions',
                          ),
                          titleTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            color: Color(0xffFF6176),
                          ),
                          content: Container(
                            width: width * 0.8,
                            height: height * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CourseCardItem(
                                          width: width,
                                          height: height,
                                          title: 'Add Session',
                                          icon: Icons.add,
                                          onTap: () {
                                            String docId =
                                                courseData.reference.id;
                                            String date =
                                                DateTime.now().toString();
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title:
                                                    Text('Add New Session...'),
                                                content: Text(
                                                  'Are You sure to Add new session?',
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      print("you choose no");
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(
                                                      'No',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    color: Colors.green,
                                                    onPressed: () {
                                                      _store.addNewSession(
                                                        docId,
                                                        date,
                                                        context,
                                                      );
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        CourseCardItem(
                                          width: width,
                                          height: height,
                                          title: 'Old Sessions',
                                          icon: Icons.book,
                                          onTap: () {
                                            String docId =
                                                courseData.reference.id;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OldSessions(docId: docId),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CourseCardItem(
                                          width: width,
                                          height: height,
                                          title: 'Verify Student',
                                          icon: Icons.mobile_friendly,
                                          onTap: () {
                                            String docId =
                                                courseData.reference.id;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CourseVerifyStudent(
                                                  courseId:
                                                      courseData['CourseId'],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        CourseCardItem(
                                          width: width,
                                          height: height,
                                          title: 'Student',
                                          icon: Icons.people,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                CourseStudent(
                                                  courseId: courseData['CourseId'],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Return',
                                style: TextStyle(
                                  color: Color(0xffFF6176),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.book),
                    title: Column(
                      children: [
                        Text(
                          courseData['CourseName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          '${courseData['CourseInstructor']}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: Container(
                      height: height * 0.15,
                      width: width * 0.15,
                      child: Image.asset('qr/qr_code.png'),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }
}
