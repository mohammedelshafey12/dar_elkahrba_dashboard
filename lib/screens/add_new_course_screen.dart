import 'package:flutter/material.dart';

class AddNewCourseScreen extends StatelessWidget {
  static const String routeName = '/Add-new-course';
  final List<String> hints = [
    'Course title',
    'Course instructor',
    'Course description',
    'Course hours',
    'Course price',
    'Course PDF Url',
  ];
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new course'),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: deviceSize.width * 0.7,
              height: deviceSize.height * 0.8,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...hints
                              .map((hint) => AddNewCourseTxtFld(hint))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Add',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromRGBO(38, 231, 122, 1)),
                minimumSize: MaterialStateProperty.all(
                  Size(deviceSize.height * 0.2, deviceSize.width * 0.04),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddNewCourseTxtFld extends StatelessWidget {
  final String hint;

  AddNewCourseTxtFld(this.hint);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1)),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(5),
            hintText: hint),
      ),
    );
  }
}
