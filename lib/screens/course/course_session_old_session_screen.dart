import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/widgets/course/course_session_old_session_card_item.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CourseSessionOldSessionScreen extends StatelessWidget {
  const CourseSessionOldSessionScreen({
    Key? key,
    this.courseId,
  });
  final courseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Old Session'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.courseCollection)
            .doc(courseId)
            .collection(Constants.coursesSessionCollection)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var sessionData = snapshot.data!.docs[index];
                return CourseSessionOldSessionCardItem(
                  courseId: courseId,
                  sessionData: sessionData,
                );
              },
            );
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}
