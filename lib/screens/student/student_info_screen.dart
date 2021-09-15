import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:dar_elkahrba/widgets/student/student_info_card_item.dart';
import 'package:flutter/material.dart';

class StudentInfoScreen extends StatelessWidget {
  const StudentInfoScreen({
    Key? key,
    required this.userId,
  });

  final userId;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Info'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.usersCollection)
            .where(
              Constants.userId,
              isEqualTo: userId,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var studentData = snapshot.data!.docs[0];
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                StudentInfoCardItem(
                  title: 'UserName',
                  subTitle: studentData[Constants.userName],
                ),
                StudentInfoCardItem(
                  title: 'UserGender',
                  subTitle: studentData[Constants.userGender],
                ),
                StudentInfoCardItem(
                  title: 'UserPhone',
                  subTitle: studentData[Constants.userPhone],
                ),
                StudentInfoCardItem(
                  title: 'UserWhatsApp',
                  subTitle: studentData[Constants.userWhatsApp],
                ),
                StudentInfoCardItem(
                  title: 'UserPlace',
                  subTitle: studentData[Constants.userPlace],
                ),
                StudentInfoCardItem(
                  title: 'UserCity',
                  subTitle: studentData[Constants.userCity],
                ),
                StudentInfoCardItem(
                  title: 'UserBirthDayDate',
                  subTitle: studentData[Constants.userBirthDayDate],
                ),
                StudentInfoCardItem(
                  title: 'UserGovrenerate',
                  subTitle: studentData[Constants.userGovrenerate],
                ),
                StudentInfoCardItem(
                  title: 'UserGraduationYear',
                  subTitle: studentData[Constants.userGraduationYear],
                ),
                StudentInfoCardItem(
                  title: 'UserDepartment',
                  subTitle: studentData[Constants.userDepartment],
                ),
                StudentInfoCardItem(
                  title: 'UserUniversity',
                  subTitle: studentData[Constants.userUniversity],
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
