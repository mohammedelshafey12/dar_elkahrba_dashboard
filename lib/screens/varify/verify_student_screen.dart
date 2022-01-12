import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/widgets/dialog_do_you_want.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;


class VerifyStudentScreen extends StatefulWidget {
  @override
  State<VerifyStudentScreen> createState() => _VerifyStudentScreenState();
}

class _VerifyStudentScreenState extends State<VerifyStudentScreen> {
  List data = [];

  Future<List<QueryDocumentSnapshot>> query() async {
    CollectionReference col1 =
        FirebaseFirestore.instance.collection(Constants.usersCollection);
    final snapshots = col1.snapshots().map((snapshot) => snapshot.docs.where(
        (doc) =>
            doc[Constants.userPhotoVerifiedUrl] != null &&
            doc[Constants.userIsVerified] != true));
    var data2 = (await snapshots.first).toList();
    setState(() {
      data = data2;
    });

    print(data[1][Constants.userName]);
    print(data.length);
    return (await snapshots.first).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query();
    // FirebaseFirestore.instance.collection(Constants.usersCollection).doc()
    //             .collection(Constants.myCoursesCollection).where(Constants.courseId , isEqualTo: "GhNswbEg4oi1gUqirPvh").get().then((value) {
    //           print(value.docs.length);
    // });



  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Store _store = Store();
    return Scaffold(
        appBar: AppBar(
          title: Text('Verify Student'),
        ),
        body: data.isEmpty
            ? LoadingPage()
            : ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var studentData = data[index];
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
                              '${studentData[Constants.userName]}',
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
                                          child: studentData[Constants
                                                      .userPhotoVerifiedUrl] ==
                                                  null
                                              ? Center(
                                                  child: Text(
                                                    'No Image Now',
                                                  ),
                                                )
                                              : Image(
                                                  image: NetworkImage(
                                                    studentData[Constants
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
                                                      href: studentData[Constants
                                                          .userPhotoVerifiedUrl]);
                                              anchorElement.download =
                                                  studentData[Constants
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
                                    '${studentData[Constants.userPhotoVerifiedUrl]}',
                                  ),
                                ),
                              ),
                            ),
                            trailing: Text(
                              studentData[Constants.courseName] == null
                                  ? "Waiting to verify"
                                  : 'Course ${studentData[Constants.courseName]}',
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
                                          return DialogDoYouWant(
                                            title:
                                                'Do you want to verify this user?',
                                            onTapYes: () {
                                              _store.verifyUser(
                                                userId: studentData[
                                                    Constants.userId],
                                                userName: studentData[
                                                    Constants.userName],
                                                courseId: studentData[
                                                    Constants.courseId],
                                                courseName: studentData[
                                                    Constants.courseName],
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
                                RaisedButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    Store store = Store();
                                    store
                                        .refuseUser(
                                            userId:
                                                studentData[Constants.userId])
                                        .whenComplete(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("User Refused")));
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      "RefuseUser",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
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
              ));
  }
}
