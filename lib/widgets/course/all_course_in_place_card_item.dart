import 'package:flutter/material.dart';

import '../../Constants.dart';
import 'all_course_in_place_card_item_dialog.dart';

class AllCourseInPlaceCardItem extends StatelessWidget {
  const AllCourseInPlaceCardItem({
    Key? key,
    required this.courseData,
  });

  final courseData;

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
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AllCourseInPlaceCardItemDialog(
                courseData: courseData,
              );
            },
          );
        },
        child: ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          leading: Icon(Icons.book),
          title: Column(
            children: [
              Text(
                courseData[Constants.courseName],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                '${courseData[Constants.courseInstructorName]}',
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
  }
}
