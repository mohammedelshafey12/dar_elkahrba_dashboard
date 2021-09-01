import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/widgets/app_drawer.dart';
import 'package:dar_elkahrba/widgets/loading_page.dart';
import 'package:dar_elkahrba/widgets/student_info_text.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class StudentScreen extends StatelessWidget {
  static const routeName = '/StudentScreen';

  const StudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Students',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: stream(context),
      drawer: AppDrawer(),
    );
  }

  Widget stream(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('UsersCollection').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var userData = snapshot.data!.docs[index];
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Student Info',
                              ),
                              titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Color(0xffFF6176),
                              ),
                              content: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Builder(
                                        builder: (BuildContext context) => InkWell(
                                          onTap: () {
                                            if (userData['UserImageUrl'] != null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => Dialog(
                                                    elevation: 16,
                                                    shape:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20)),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: width * 0.8,
                                                          height: height * 0.8,
                                                          child: userData[Constants
                                                              .userImageUrl] ==
                                                              null
                                                              ? Center(
                                                              child:
                                                              CircularProgressIndicator())
                                                              : Image(
                                                              image: NetworkImage(
                                                                  userData[
                                                                  Constants
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
                                                                  href: userData[
                                                                  Constants
                                                                      .userImageUrl]);
                                                              anchorElement
                                                                  .download =
                                                              userData[Constants
                                                                  .userImageUrl];

                                                              anchorElement
                                                                  .click();
                                                            },
                                                            child: Center(
                                                              child: Text(
                                                                'Download',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "This user has no image yet..",
                                                  style: TextStyle(
                                                      fontFamily: 'custom_font'),
                                                ),
                                              ));
                                            }
                                          },
                                          child: Container(
                                            width: width * 0.2,
                                            height: height * 0.2,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(15.0),
                                              child: Image.network(
                                                userData['UserImageUrl'] == null
                                                    ? 'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png'
                                                    : userData['UserImageUrl'],
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
                                        subtitle: userData['UserName'],
                                      ),
                                      StudentInfoText(
                                        title: 'Gender',
                                        subtitle: userData['UserGender'],
                                      ),
                                      StudentInfoText(
                                        title: 'Phone',
                                        subtitle: userData['UserPhone'],
                                      ),
                                      StudentInfoText(
                                        title: 'WhatsApp',
                                        subtitle: userData['UserWhatsApp'],
                                      ),
                                      StudentInfoText(
                                        title: 'BirthDayDate',
                                        subtitle: userData['UserBirthDayDate'],
                                      ),
                                      StudentInfoText(
                                        title: 'Place',
                                        subtitle: userData['UserPlace'],
                                      ),
                                      StudentInfoText(
                                        title: 'City',
                                        subtitle: userData['UserCity'],
                                      ),
                                      StudentInfoText(
                                        title: 'University',
                                        subtitle: userData['UserUniversity'],
                                      ),
                                      StudentInfoText(
                                        title: 'Department',
                                        subtitle: userData['UserDepartment'],
                                      ),
                                      StudentInfoText(
                                        title: 'Govrenerate',
                                        subtitle: userData['UserGovrenerate'],
                                      ),
                                      StudentInfoText(
                                        title: 'Graduation Year',
                                        subtitle: userData['UserGraduationYear'],
                                      ),
                                    ],
                                  ),
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
                      child: ListTile(
                        leading: Container(
                          width: 50.0,
                          height: 50.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              userData['UserImageUrl'] == null
                                  ? 'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png'
                                  : userData['UserImageUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Column(
                          children: [
                            Text(
                              userData['UserName'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              '${userData['UserPhone']}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.menu,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: height * 0.05,
                bottom: height * 0.05,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15.0),
                  onTap: (){
                    var excel = Excel.createExcel();
                    Sheet sheetObject = excel['Sheet1'];
                    sheetObject.cell(CellIndex.indexByString("A ${1}",),).value = 'UserName';
                    sheetObject.cell(CellIndex.indexByString("B ${1}",),).value = 'UserGender';
                    sheetObject.cell(CellIndex.indexByString("C ${1}",),).value = 'UserPhone';
                    sheetObject.cell(CellIndex.indexByString("D ${1}",),).value = 'UserCity';
                    sheetObject.cell(CellIndex.indexByString("E ${1}",),).value = 'UserPlace';
                    sheetObject.cell(CellIndex.indexByString("F ${1}",),).value = 'UserUniversity';
                    sheetObject.cell(CellIndex.indexByString("G ${1}",),).value = 'UserDepartment';
                    sheetObject.cell(CellIndex.indexByString("H ${1}",),).value = 'UserBirthDayDate';
                    sheetObject.cell(CellIndex.indexByString("I ${1}",),).value = 'UserGovrenerate';
                    sheetObject.cell(CellIndex.indexByString("J ${1}",),).value = 'UserGraduationYear';
                    sheetObject.cell(CellIndex.indexByString("K ${1}",),).value = 'UserWhatsApp';

                    for (int i = 1; i < snapshot.data!.docs.length + 1; i++) {
                      sheetObject.cell(CellIndex.indexByString("A ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserName'];
                      sheetObject.cell(CellIndex.indexByString("B ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserGender'];
                      sheetObject.cell(CellIndex.indexByString("C ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserPhone'];
                      sheetObject.cell(CellIndex.indexByString("D ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserPlace'];
                      sheetObject.cell(CellIndex.indexByString("E ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserCity'];
                      sheetObject.cell(CellIndex.indexByString("F ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserUniversity'];
                      sheetObject.cell(CellIndex.indexByString("G ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserDepartment'];
                      sheetObject.cell(CellIndex.indexByString("H ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserBirthDayDate'];
                      sheetObject.cell(CellIndex.indexByString("I ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserGovrenerate'];
                      sheetObject.cell(CellIndex.indexByString("J ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserGraduationYear'];
                      sheetObject.cell(CellIndex.indexByString("K ${i + 1}",),).value = snapshot.data!.docs[i - 1]['UserWhatsApp'];
                    }

                    excel.save(
                      fileName: "AllStudent.xlsx",
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 7,
                          blurRadius: 7,
                          offset: Offset(3, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.download_outlined),
                        SizedBox(width: 10.0,),
                        Text(
                          'Download Excel Sheet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }
}
