import 'package:dar_elkahrba/Servises/store.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import '../../Constants.dart';
import '../dialog_do_you_want.dart';

class VerifyDoctorCardItem extends StatelessWidget {
  const VerifyDoctorCardItem({Key? key, required this.doctorData,});
  final doctorData;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Store _store = Store();
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
       contentPadding: const EdgeInsets.all(20.0),
        leading: Icon(
          Icons.person,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                'Name: ${doctorData[Constants.doctorName]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Place: ${doctorData[Constants.doctorPlace]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(width: width * 0.005,),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogDoYouWant(
                      title:
                      'Do you want to verify this user?',
                      onTapYes: () {
                        _store.verifyDoctor(
                          doctorId: doctorData[Constants.doctorId],
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
            )
          ],
        ),
      ),
    );
  }
}
