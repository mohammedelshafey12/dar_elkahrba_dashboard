import 'dart:io';
import 'dart:typed_data';

import 'package:dar_elkahrba/Models/CourseModel.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/providers/course.dart';
import 'package:dar_elkahrba/providers/modelHud.dart';
import 'package:dar_elkahrba/screens/course/courses_overview_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewCourseScreen extends StatefulWidget {
  static const String routeName = '/Add-new-course';

  @override
  _AddNewCourseScreenState createState() => _AddNewCourseScreenState();
}

class _AddNewCourseScreenState extends State<AddNewCourseScreen> {
  var _isInit = true;
  var _isUploading = false;
  File? pdf;
  var _pdfName = '';
  String? _pdfName2;
  Store _store = Store();
  String? courseName,
      courseId,
      courseInstructor,
      courseDesc,
      courseHours,
      coursePrice;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add new course'),
      ),
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<modelHud>(context).isloading,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: deviceSize.width * 0.7,
                  height: deviceSize.height * 0.8,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      courseName = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Please Enter the title';
                                    else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Course Title'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      courseId = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Please Enter the courseId ';
                                    else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Course Id'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      courseInstructor = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Please Enter the instructor name';
                                    else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Course Instructor'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      courseDesc = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Please Enter the description';
                                    else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Course Description'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      courseHours = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Please Enter the hours';
                                    if (double.tryParse(value) == null)
                                      return 'Please Enter a number';
                                    if (double.tryParse(value)! < 0)
                                      return 'Please Enter a valid number';
                                    else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Course Hours'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      coursePrice = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'Please Enter the price';
                                    if (double.tryParse(value) == null)
                                      return 'Please Enter a numeric price';
                                    if (double.tryParse(value)! < 0)
                                      return 'Please Enter a valid price';
                                    else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'Course Price'),
                                ),
                              ),
                              (_isUploading)
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      width: deviceSize.width * 0.2,
                                      child: Card(
                                        elevation: 3,
                                        child: InkWell(
                                          onTap: _openPicker,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              child: Text('PDF'),
                                            ),
                                            title: Text((_pdfName.isEmpty)
                                                ? 'Click to add course brochure'
                                                : _pdfName),
                                            trailing: Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_pdfName2 != null) {
                          //  Provider.of<modelHud>(context, listen: false).isprogressloding(true);
                          _store.addCourse(
                              CourseModel(
                                  courseName,
                                  courseId,
                                  courseDesc,
                                  _pdfName2,
                                  courseInstructor,
                                  int.parse(coursePrice!),
                                  int.parse(courseHours!)),
                              context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Course added successfully",
                              style: TextStyle(fontFamily: 'customFont'),
                            ),
                          ));
                          _formKey.currentState!.reset();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CoursesOverviewScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(38, 231, 122, 1)),
                      minimumSize: MaterialStateProperty.all(
                        Size(deviceSize.height * 0.2, deviceSize.width * 0.04),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openPicker() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      Provider.of<modelHud>(context, listen: false).isprogressloding(true);
      final uploadedPdf = result.files.single.bytes;
      final loadedPdfName = result.files.single.name;

      Reference reference =
          FirebaseStorage.instance.ref().child('${Uuid().v1()}.pdf');
      final uploadTask = reference.putData(
        uploadedPdf!,
        SettableMetadata(
          contentType: 'application/pdf',
        ),
      );

      uploadTask.whenComplete(() async {
        Provider.of<modelHud>(context, listen: false).isprogressloding(false);
        final pdf = await uploadTask.snapshot.ref.getDownloadURL();
        print(pdf);
        //_editedCourse = _editedCourse.copyWith(pdfUrl: pdf);
        setState(() {
          _pdfName = loadedPdfName;
          _pdfName2 = pdf;
          _isUploading = false;
        });
        // Scaffold.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //     "First pick Image By click on photo",
        //     style: TextStyle(fontFamily: 'customFont'),
        //   ),
        // ));
      });
    }
  }
}
