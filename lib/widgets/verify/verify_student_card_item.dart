import 'package:dar_elkahrba/Servises/store.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import '../../Constants.dart';
import '../dialog_do_you_want.dart';

class VerifyStudentCardItem extends StatelessWidget {
  const VerifyStudentCardItem({
    Key? key,
    required this.studentData,
  });

  final studentData;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Store _store = Store();
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20.0),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
            ),
          ],
        ),
        title: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Name: ${studentData[Constants.userName]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Place: ${studentData[Constants.userPlace]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Course: ${studentData[Constants.courseName]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    color: Colors.deepOrange,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.8,
                                height: height * 0.8,
                                child: studentData[
                                            Constants.userPhotoVerifiedUrl] ==
                                        null
                                    ? Center(
                                        child: Text(
                                          'No Image Now',
                                        ),
                                      )
                                    : Image(
                                        image: NetworkImage(
                                          studentData[
                                              Constants.userPhotoVerifiedUrl],
                                        ),
                                      ),
                              ),
                              Container(
                                color: Colors.green,
                                width: width * 0.5,
                                child: RaisedButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    html.AnchorElement anchorElement =
                                        new html.AnchorElement(
                                            href: studentData[Constants
                                                .userPhotoVerifiedUrl]);
                                    anchorElement.download = studentData[
                                        Constants.userPhotoVerifiedUrl];

                                    anchorElement.click();
                                  },
                                  child: Center(
                                    child: Text(
                                      'Download',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                color: Colors.red,
                                width: width * 0.5,
                                child: RaisedButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      'Return',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Show Photo Verify",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogDoYouWant(
                            title: 'Do you want to verify this user?',
                            onTapYes: () {
                              _store.verifyUser(
                                userId: studentData[Constants.userId],
                                userName: studentData[Constants.userName],
                                courseId: studentData[Constants.courseId],
                                courseName: studentData[Constants.courseName],
                              );
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
