import 'package:dar_elkahrba/screens/student/all_student_in_place_screen.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class StudentPlaceCardItem extends StatelessWidget {
  const StudentPlaceCardItem({
    Key? key,
    required this.icon,
    required this.title,
  });

  final icon;
  final title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            Constants.navigatorPush(
              context: context,
              screen: AllStudentInPlaceScreen(
                place: title,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: height * 0.1,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
