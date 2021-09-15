import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/screens/student/student_info_screen.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CourseAllStudentScreen extends StatelessWidget {
  const CourseAllStudentScreen({
    Key? key,
    required this.courseData,
  });

  final courseData;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Student'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.courseStudentCollection)
            .doc(courseData[Constants.courseId])
            .collection(Constants.studentCollection)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var studentData = snapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          Constants.navigatorPush(
                            context: context,
                            screen: StudentInfoScreen(
                              userId: studentData[Constants.userId],
                            ),
                          );
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(20.0,),
                          leading: Icon(Icons.person),
                          title: Center(
                            child: Text(
                              '${studentData[Constants.userName]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.info,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: width * 0.05,
                  bottom: height * 0.05,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    onTap: () {
                      var excel = Excel.createExcel();
                      Sheet sheetObject = excel['Sheet1'];
                      sheetObject
                          .cell(
                        CellIndex.indexByString(
                          "A ${1}",
                        ),
                      )
                          .value = 'UserName';
                      sheetObject
                          .cell(
                        CellIndex.indexByString(
                          "B ${1}",
                        ),
                      )
                          .value = 'CourseName';
                      for (int i = 1; i <= snapshot.data!.docs.length; i++) {
                        sheetObject
                            .cell(
                          CellIndex.indexByString(
                            "A ${i + 1}",
                          ),
                        )
                            .value =
                        snapshot.data!.docs[i - 1][Constants.userName];
                        sheetObject
                            .cell(
                          CellIndex.indexByString(
                            "B ${i + 1}",
                          ),
                        )
                            .value = courseData[Constants.courseName];
                      }
                      excel.save(
                        fileName:
                        "AllStudentInCourse (${courseData[Constants
                            .courseName]}).xlsx",
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 7,
                            blurRadius: 7,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.download_outlined),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Download Excel Sheet',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}
