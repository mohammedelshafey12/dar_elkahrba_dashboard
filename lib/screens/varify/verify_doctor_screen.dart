import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:dar_elkahrba/widgets/verify/verify_doctor_card_item.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class VerifyDoctorScreen extends StatelessWidget {
  const VerifyDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Store _store = Store();
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Doctor'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Constants.doctorCollection)
            .where(Constants.doctorIsVerify, isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doctorData = snapshot.data!.docs[index];
                return VerifyDoctorCardItem(
                  doctorData: doctorData,
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
