import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class VerifiedScreen extends StatefulWidget {
  static const routeName = '/VerifiedScreen';

  @override
  _VerifiedScreenState createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify new users'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.userDataVerfied(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
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
                                '${data[index][Constants.userName]}',
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
                                            child: data[index][Constants
                                                        .userPhotoVerifiedUrl] ==
                                                    null
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : Image(
                                                    image: NetworkImage(
                                                      data[index][Constants
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
                                                html.AnchorElement
                                                    anchorElement =
                                                    new html.AnchorElement(
                                                        href: data[index][Constants
                                                            .userPhotoVerifiedUrl]);
                                                anchorElement.download =
                                                    data[index][Constants
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
                                      '${data[index][Constants.userPhotoVerifiedUrl]}',
                                    ),
                                  ),
                                ),
                              ),
                              trailing: Text(
                                'Course ${data[index]['CourseName']}',
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
                                                  _store.verifyUser(
                                                    userId: data[index]['UserId'],
                                                    userName: data[index]['UserName'],
                                                    courseId:  data[index]['CourseId'],
                                                    courseName:  data[index]['CourseName'],
                                                  );
                                                  Navigator.of(context)
                                                      .pop();
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
                                    onPressed: () {},
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
                });
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }

}
