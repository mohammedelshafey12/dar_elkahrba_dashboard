import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class SessionStudent extends StatelessWidget {
  const SessionStudent({
    Key? key,
    required this.courseId,
    required this.sessionId,
  });

  final courseId;
  final sessionId;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student in This Sessions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('CourseCollection')
              .doc(courseId)
              .collection('CoursesSessionCollection')
              .doc(sessionId)
              .collection('CoursesSessionStudentCollection')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var studentData = snapshot.data!.docs;
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 50.0,
                            height: 50.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.network(
                                studentData[index]['StudentImageUrl'] == null
                                    ? 'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png'
                                    : studentData[index]['StudentImageUrl'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Center(
                            child: Text(
                              '${studentData[index]['StudentName']}',
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
                        sheetObject.cell(CellIndex.indexByString("B ${1}",),).value = 'Session';
                        for (int i = 1; i <= snapshot.data!.docs.length; i++) {
                          sheetObject.cell(CellIndex.indexByString("A ${i + 1}",),).value = snapshot.data!.docs[i - 1]['StudentName'];
                          sheetObject.cell(CellIndex.indexByString("B ${i + 1}",),).value = sessionId;
                        }
                        excel.save(
                          fileName: "AllStudentInSession ($sessionId).xlsx",
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
      ),
    );
  }
}
