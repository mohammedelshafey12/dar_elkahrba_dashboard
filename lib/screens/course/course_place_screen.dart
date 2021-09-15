import 'package:dar_elkahrba/widgets/course/course_place_card_item.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class CoursePlaceScreen extends StatelessWidget {
  const CoursePlaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Place',),
      ),
      body: Center(
        child: Container(
          width: width * 0.8,
          height: height * 0.6,
          child: Row(
            children: [
              CoursePlaceCardItem(
                title: Constants.nasrCityPlace,
                icon: Icons.home,
              ),
              SizedBox(width: width * 0.1,),
              CoursePlaceCardItem(
                title: Constants.elMansouraPlace,
                icon: Icons.home,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
