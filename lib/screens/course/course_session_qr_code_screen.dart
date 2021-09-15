import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CourseSessionQrCodeScreen extends StatelessWidget {
  const CourseSessionQrCodeScreen({
    Key? key,
    required this.sessionName,
    required this.sessionDate,
  });

  final sessionName;
  final sessionDate;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Qr Code for [ $sessionName ]',
        ),
      ),
      body: Center(
        child: Container(
          width: height * 0.8,
          height: height * 0.8,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: QrImage(
                data: sessionDate,
                version: QrVersions.auto,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
