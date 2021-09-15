import 'package:dar_elkahrba/screens/student/student_info_screen.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class AllStudentInPlaceCardItem extends StatelessWidget {
  const AllStudentInPlaceCardItem({
    Key? key,
    required this.studentData,
  });
  final studentData;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 3.0,
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
          contentPadding: const EdgeInsets.all(10.0),
          leading: Icon(Icons.person),
          title: Text(
            studentData[Constants.userName],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
          trailing: Icon(Icons.info),
        ),
      ),
    );
  }
}
