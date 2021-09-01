import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:dar_elkahrba/widgets/student_info_text.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class CourseStudentInfo extends StatefulWidget {
  const CourseStudentInfo({
    Key? key,
    required this.uid,
  });

  final uid;

  @override
  _CourseStudentInfoState createState() => _CourseStudentInfoState();
}

class _CourseStudentInfoState extends State<CourseStudentInfo> {
  var doc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    var document = await FirebaseFirestore.instance
        .collection('UsersCollection')
        .doc(widget.uid)
        .get();
    setState(() {
      doc = document;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Info'),
      ),
      backgroundColor: Colors.white,
      body: doc == null
          ? LoadingPage()
          : Center(
              child: Container(
                  width: width * 0.6,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Builder(
                            builder: (BuildContext context) => InkWell(
                              onTap: () async {
                                if (doc['UserImageUrl'] != null) {
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
                                                  child: doc[Constants
                                                              .userImageUrl] ==
                                                          null
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                      : Image(
                                                          image: NetworkImage(
                                                              doc[Constants
                                                                  .userImageUrl])),
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
                                                              href: doc[Constants
                                                                  .userImageUrl]);
                                                      anchorElement.download =
                                                          doc[Constants
                                                              .userImageUrl];

                                                      anchorElement.click();
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                        'Download',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "This user has no image yet..",
                                        style: TextStyle(
                                            fontFamily: 'custom_font'),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: width * 0.2,
                                height: height * 0.2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          StudentInfoText(
                            title: 'Name',
                            subtitle: doc['UserName'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'Gender',
                            subtitle: doc['UserGender'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'Phone',
                            subtitle: doc['UserPhone'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'WhatsApp',
                            subtitle: doc['UserWhatsApp'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'BirthDayDate',
                            subtitle: doc['UserBirthDayDate'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'Place',
                            subtitle: doc['UserPlace'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'City',
                            subtitle: doc['UserCity'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'University',
                            subtitle: doc['UserUniversity'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'Department',
                            subtitle: doc['UserDepartment'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'Govrenerate',
                            subtitle: doc['UserGovrenerate'] ?? "",
                          ),
                          StudentInfoText(
                            title: 'Graduation Year',
                            subtitle: doc['UserGraduationYear'] ?? "",
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
    );
  }
}
