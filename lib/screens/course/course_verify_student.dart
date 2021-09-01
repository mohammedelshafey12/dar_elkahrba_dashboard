import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/widgets/app_drawer.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import '../../Constants.dart';

class CourseVerifyStudent extends StatelessWidget {
  CourseVerifyStudent({
    Key? key,
    required this.courseId,
  });

  final String courseId;

  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Course Verify Student'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.courseVerifyStudent(
          courseId: courseId,
        ),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var courseVerifyStudent = snapshot.data!.docs;
            return ListView.builder(
              itemCount: courseVerifyStudent.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.person,
                              ),
                            ),
                            title: Text(
                              '${courseVerifyStudent[index]['UserName']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    elevation: 16,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: width * 0.8,
                                          height: height * 0.8,
                                          child: courseVerifyStudent[index][
                                                      Constants
                                                          .userPhotoVerifiedUrl] ==
                                                  null
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Image(
                                                  image: NetworkImage(
                                                    courseVerifyStudent[index][
                                                        Constants
                                                            .userPhotoVerifiedUrl],
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
                                                      href: courseVerifyStudent[
                                                              index][
                                                          Constants
                                                              .userPhotoVerifiedUrl]);
                                              anchorElement.download =
                                                  courseVerifyStudent[index][
                                                      Constants
                                                          .userPhotoVerifiedUrl];

                                              anchorElement.click();
                                            },
                                            child: Center(
                                              child: Text(
                                                'Download',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: width * 0.3,
                                height: height * 0.23,
                                child: Image(
                                  image: NetworkImage(
                                    '${courseVerifyStudent[index][Constants.userPhotoVerifiedUrl]}',
                                  ),
                                ),
                              ),
                            ),
                            trailing: Text(
                              'Course ${courseVerifyStudent[index]['CourseName']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    color: Colors.green,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Verified...'),
                                          content: Text(
                                              'Do you want to verify this user?'),
                                          actions: <Widget>[
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
                                            FlatButton(
                                              color: Colors.green,
                                              onPressed: () {
                                                _store.verifyCourse(
                                                  docId: courseVerifyStudent[index].reference.id,
                                                  userId: courseVerifyStudent[index]['UserId'],
                                                  userName: courseVerifyStudent[index]['UserName'],
                                                  courseId: courseId,
                                                  courseName: courseVerifyStudent[index]['CourseName'],
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                RaisedButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    _store.deleteDoc(courseVerifyStudent[index].reference.id);
                                  },
                                  child: Center(
                                    child: Text(
                                      "RefuseUser",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
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
