import 'package:dar_elkahrba/Servises/store.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import 'all_course_in_place_card_item_dialog.dart';

class AllCourseInPlaceCardItem extends StatelessWidget {
  const AllCourseInPlaceCardItem({
    Key? key,
    required this.courseData,
    required this.courseId
  });

  final courseData;
  final String courseId;

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
          trailing: IconButton(icon:Icon(Icons.delete_forever),color: Colors.red, onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('delete',style: TextStyle(color: Colors.red),),
                  content: Text(
                      'Do you want to delete this course?'),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      onPressed: () {
                        Store store = Store();
                        Constants.dialogLoading(
                          context: context,
                          title: 'deleting this course',
                        );
                         store.deleteCourse(courseId: courseId,context: context).then((value) {
                           Navigator.pop(context);
                           Navigator.pop(context);
                         }
                         );

                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            color: Colors.white),
                      ),
                    ),

                    FlatButton(
                      color: Colors.red,
                      onPressed: () {
                        print("you choose no");
                        Navigator.of(context)
                            .pop(false);
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                            color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },),
        ),
      ),
    );
  }
}
