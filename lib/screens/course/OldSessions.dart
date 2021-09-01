import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/screens/session_student.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:flutter/material.dart';

class OldSessions extends StatefulWidget {
  static const routeName = '/OldSession';
  String docId;

  OldSessions({Key? key, required this.docId}) : super(key: key);

  @override
  _OldSessionsState createState() => _OldSessionsState();
}

class _OldSessionsState extends State<OldSessions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Old Sessions"),
      ),
      body: stream(context),
    );
  }

  Widget stream(context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(Constants.courseCollection)
          .doc(widget.docId)
          .collection(Constants.coursesSessionCollection)
          .orderBy("SessionId", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var sessionData = snapshot.data!.docs[index];
              return Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SessionStudent(
                            courseId: widget.docId,
                            sessionId: sessionData['SessionId'],
                          );
                        },
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.book),
                    title: Column(
                      children: [
                        Text(
                          sessionData['SessionId'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: Container(
                      height: height * 0.15,
                      width: width * 0.15,
                      child: Image.asset('qr/qr_code.png'),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }
}
