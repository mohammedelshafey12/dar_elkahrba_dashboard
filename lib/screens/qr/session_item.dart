import 'package:dar_elkahrba/screens/qr/session_item_card.dart';
import 'package:dar_elkahrba/screens/qr/sessions.dart';
import 'package:dar_elkahrba/screens/session_student.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SessionItem extends StatelessWidget {
  String date;
  String courseId;

  SessionItem({
    Key? key,
    required this.date,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SessionItemCard(
              srcImage: 'qr/qr_code.png',
              title: 'Generate Qr Code',
              onTapItem: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Scan Qr Code',
                      ),
                      titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Color(0xffFF6176),
                      ),
                      content: Container(
                        width: width * 0.9,
                        height: height * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: width * 0.6,
                              height: height * 0.5,
                              child: QrImage(
                                data: date,
                                version: QrVersions.auto,
                              ),
                            ),
                            Text(
                              'Scan Code For Attend',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            'Return',
                            style: TextStyle(
                              color: Color(0xffFF6176),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(
              width: width * 0.04,
            ),
            SessionItemCard(
              srcImage: 'qr/group.png',
              title: 'Student',
              onTapItem: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SessionStudent(
                      sessionId: date,
                      courseId: courseId,
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
