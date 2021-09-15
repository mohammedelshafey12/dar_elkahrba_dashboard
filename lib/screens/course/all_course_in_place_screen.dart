import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/widgets/course/all_course_in_place_card_item.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class AllCourseInPlaceScreen extends StatelessWidget {
  const AllCourseInPlaceScreen({
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
          'All Course In $place',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.courseCollection)
            .where(
              Constants.coursePlace,
              isEqualTo: place,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var courseData =  snapshot.data!.docs[index];
                return  AllCourseInPlaceCardItem(
                  courseData: courseData,
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
