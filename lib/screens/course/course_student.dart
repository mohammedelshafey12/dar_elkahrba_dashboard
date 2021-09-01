import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/screens/course/course_student_info.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:dar_elkahrba/widgets/student_info_text.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class CourseStudent extends StatelessWidget {
  final String courseId;

  const CourseStudent({
    Key? key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Student'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('CourseStudentCollection')
            .doc(courseId)
            .collection('StudentCollection')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var courseStudent = snapshot.data!.docs[index];
                  String uid = courseStudent["UserId"];
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CourseStudentInfo(
                              uid: uid,
                            ),
                          )
                        );
                      },
                      child: ListTile(
                        leading: Container(
                          width: 50.0,
                          height: 50.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Center(
                          child: Text(
                            '${courseStudent['UserName']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.menu,
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
                    onTap: (){
                      var excel = Excel.createExcel();
                      Sheet sheetObject = excel['Sheet1'];
                      sheetObject.cell(CellIndex.indexByString("A ${1}",),).value = 'UserName';
                      sheetObject.cell(CellIndex.indexByString("B ${1}",),).value = 'CourseName';
                      for (int i = 1; i < snapshot.data!.docs.length + 1; i++) {
                        sheetObject.cell(CellIndex.indexByString("A ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserName'];
                        sheetObject.cell(CellIndex.indexByString("B ${i + 1}",),).value = snapshot.data!.docs[i - 1]['CourseName'];
                      }

                      excel.save(
                        fileName: "AllStudentInCourse${snapshot.data!.docs[0]['CourseName']}.xlsx",
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
                          SizedBox(width: 10.0,),
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
              ]
            );
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}
