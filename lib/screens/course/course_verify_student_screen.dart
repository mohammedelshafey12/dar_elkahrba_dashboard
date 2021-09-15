import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../../constants.dart';
import '../../widgets/loading_page.dart';

class CourseVerifyStudentScreen extends StatelessWidget {
  const CourseVerifyStudentScreen({
    Key? key,
    required this.courseId,
  });

  final courseId;

  @override
  Widget build(BuildContext context) {
    Store _store = Store();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Verify Student'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.courseVerifyCollection)
            .where(Constants.courseId, isEqualTo: courseId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var courseVerifyData = snapshot.data!.docs[index];
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
                          leading: Icon(
                            Icons.person,
                          ),
                          title: Text(
                            '${courseVerifyData[Constants.userName]}',
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: width * 0.8,
                                        height: height * 0.8,
                                        child: courseVerifyData[Constants
                                            .userPhotoVerifiedUrl] ==
                                            null
                                            ? Center(
                                          child: Text(
                                            'No Image Now',
                                          ),
                                        )
                                            : Image(
                                          image: NetworkImage(
                                            courseVerifyData[Constants
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
                                                href: courseVerifyData[Constants
                                                    .userPhotoVerifiedUrl]);
                                            anchorElement.download =
                                            courseVerifyData[Constants
                                                .userPhotoVerifiedUrl];
                                            anchorElement.click();
                                          },
                                          child: Center(
                                            child: Text(
                                              'Download',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
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
                                  '${courseVerifyData[Constants.userPhotoVerifiedUrl]}',
                                ),
                              ),
                            ),
                          ),
                          trailing: Text(
                            'Course ${courseVerifyData[Constants.courseName]}',
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
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Verified...'),
                                          content: Text(
                                              'Do you want to verify this user?'),
                                          actions: <Widget>[
                                            FlatButton(
                                              color: Colors.green,
                                              onPressed: () {
                                                _store.verifyCourse(
                                                  docId: courseVerifyData.reference.id,
                                                  userId: courseVerifyData[Constants.userId],
                                                  userName: courseVerifyData[Constants.userName],
                                                  courseId: courseVerifyData[Constants.courseId],
                                                  courseName: courseVerifyData[Constants.courseName],
                                                );
                                                Navigator.pop(context);
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
                                  _store.deleteDoc(courseVerifyData.reference.id);
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
                    ),
                  ),
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
