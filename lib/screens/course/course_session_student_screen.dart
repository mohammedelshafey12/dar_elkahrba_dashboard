import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/screens/student/student_info_screen.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CourseSessionStudentScreen extends StatelessWidget {
  const CourseSessionStudentScreen(
      {Key? key, required this.courseId, required this.sessionDate, required this.sessionName,})
  ;

  final courseId;
  final sessionName;
  final sessionDate;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student In [ $sessionName ]'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.courseCollection)
            .doc(courseId)
            .collection(Constants.coursesSessionCollection)
            .doc(sessionDate)
            .collection(Constants.coursesSessionStudentCollection)
            .snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(20.0) ,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
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
                          contentPadding: const EdgeInsets.all(20.0),
                          leading: Icon(Icons.book),
                          title: Column(
                            children: [
                              Text(
                                studentData[Constants.userName],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                '${studentData[Constants.userName]}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.info),
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
                      sheetObject.cell(CellIndex.indexByString("B ${1}",),).value = 'SessionName';
                      sheetObject.cell(CellIndex.indexByString("C ${1}",),).value = 'SessionDate';
                      for (int i = 1; i <= snapshot.data!.docs.length; i++) {
                        sheetObject.cell(CellIndex.indexByString("A ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userName];
                        sheetObject.cell(CellIndex.indexByString("B ${i + 1}",),).value = sessionName;
                        sheetObject.cell(CellIndex.indexByString("C ${i + 1}",),).value = sessionDate;
                      }
                      excel.save(
                        fileName: "AllStudentInSession ($sessionName).xlsx",
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
