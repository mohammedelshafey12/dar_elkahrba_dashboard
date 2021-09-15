import 'package:dar_elkahrba/screens/course/all_course_in_place_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class CoursePlaceCardItem extends StatelessWidget {
  const CoursePlaceCardItem({
    Key? key,
    required this.title,
    required this.icon,
  });

  final title;
  final icon;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: (){
            Constants.navigatorPush(
              context: context,
              screen: AllCourseInPlaceScreen(
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
