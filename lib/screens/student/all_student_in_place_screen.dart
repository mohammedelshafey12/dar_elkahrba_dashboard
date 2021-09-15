import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/widgets/course/all_course_in_place_card_item.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:dar_elkahrba/widgets/student/all_student_in_place_card_item.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class AllStudentInPlaceScreen extends StatelessWidget {
  const AllStudentInPlaceScreen({
    Key? key,
    required this.place,
  });

  final place;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Student In $place',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.usersCollection)
            .where(
              Constants.userPlace,
              isEqualTo: place,
            )
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
                    return AllStudentInPlaceCardItem(
                      studentData: studentData,
                    );
                  },
                ),
                Positioned(
                  right: height * 0.05,
                  bottom: height * 0.05,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    onTap: (){
                      var excel = Excel.createExcel();
                      Sheet sheetObject = excel['Sheet1'];
                      sheetObject.cell(CellIndex.indexByString("A ${1}",),).value = 'UserName';
                      sheetObject.cell(CellIndex.indexByString("B ${1}",),).value = 'UserGender';
                      sheetObject.cell(CellIndex.indexByString("C ${1}",),).value = 'UserPhone';
                      sheetObject.cell(CellIndex.indexByString("D ${1}",),).value = 'UserCity';
                      sheetObject.cell(CellIndex.indexByString("E ${1}",),).value = 'UserPlace';
                      sheetObject.cell(CellIndex.indexByString("F ${1}",),).value = 'UserUniversity';
                      sheetObject.cell(CellIndex.indexByString("G ${1}",),).value = 'UserDepartment';
                      sheetObject.cell(CellIndex.indexByString("H ${1}",),).value = 'UserBirthDayDate';
                      sheetObject.cell(CellIndex.indexByString("I ${1}",),).value = 'UserGovrenerate';
                      sheetObject.cell(CellIndex.indexByString("J ${1}",),).value = 'UserGraduationYear';
                      sheetObject.cell(CellIndex.indexByString("K ${1}",),).value = 'UserWhatsApp';

                      for (int i = 1; i < snapshot.data!.docs.length + 1; i++) {
                        sheetObject.cell(CellIndex.indexByString("A ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userName];
                        sheetObject.cell(CellIndex.indexByString("B ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userGender];
                        sheetObject.cell(CellIndex.indexByString("C ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userPhone];
                        sheetObject.cell(CellIndex.indexByString("D ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userPlace];
                        sheetObject.cell(CellIndex.indexByString("E ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userCity];
                        sheetObject.cell(CellIndex.indexByString("F ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userUniversity];
                        sheetObject.cell(CellIndex.indexByString("G ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userDepartment];
                        sheetObject.cell(CellIndex.indexByString("H ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userBirthDayDate];
                        sheetObject.cell(CellIndex.indexByString("I ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userGovrenerate];
                        sheetObject.cell(CellIndex.indexByString("J ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userGraduationYear];
                        sheetObject.cell(CellIndex.indexByString("K ${i + 1}",),).value = snapshot.data!.docs[i - 1][Constants.userWhatsApp];
                      }

                      excel.save(
                        fileName: "AllStudent.xlsx",
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
