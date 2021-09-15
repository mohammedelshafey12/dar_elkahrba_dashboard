import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/widgets/dialog_do_you_want.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:dar_elkahrba/widgets/verify/verify_student_card_item.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../../constants.dart';

class VerifyStudentScreen extends StatelessWidget {
  const VerifyStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Store _store = Store();
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Student'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.usersCollection)
            .where(Constants.userIsVerified, isEqualTo: false)
            .where(Constants.userPhotoVerifiedUrl, isNotEqualTo: null)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var studentData = snapshot.data!.docs[index];
                return VerifyStudentCardItem(
                  studentData: studentData,
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
