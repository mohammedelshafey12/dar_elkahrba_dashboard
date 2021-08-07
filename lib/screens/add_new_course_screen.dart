import 'dart:io';
import 'dart:typed_data';

import 'package:dar_elkahrba/providers/course.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  var _pdfName = '';

  var _editedCourse = Course(
      id: '',
      title: '',
      instructor: '',
      hours: 0,
      price: 0.0,
      description: '',
      pdfUrl: '');

  var initialValues = {
    'title': '',
    'instructor': '',
    'hours': '',
    'price': '',
    'description': '',
    'pdfUrl': ''
  };

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      final id = ModalRoute.of(context)!.settings.arguments as String;
      if (id.isNotEmpty) {
        final loadedCourse = Provider.of<CoursesProvider>(context)
            .courses
            .firstWhere((course) => course.id == id);
        _editedCourse = loadedCourse;
        initialValues = {
          'title': _editedCourse.title,
          'instructor': _editedCourse.instructor,
          'description': _editedCourse.description,
          'hours': _editedCourse.hours.toString(),
          'price': _editedCourse.price.toString(),
          'pdfUrl': _editedCourse.pdfUrl,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValidate = _formKey.currentState!.validate();
    if (!isValidate) {
      return;
    }
    _formKey.currentState!.save();
    if (_editedCourse.id.isNotEmpty) {
      Provider.of<CoursesProvider>(context, listen: false)
          .updateCourse(_editedCourse, _editedCourse.id);
    } else {
      Provider.of<CoursesProvider>(context, listen: false)
          .addCourse(_editedCourse);
      print(_editedCourse.instructor);

      print(_editedCourse.pdfUrl);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new course'),
      ),
      body: Center(
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
                                initialValue: initialValues['title'],
                                onSaved: (value) {
                                  _editedCourse =
                                      _editedCourse.copyWith(title: value);
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
                                initialValue: initialValues['instructor'],
                                onSaved: (value) {
                                  _editedCourse =
                                      _editedCourse.copyWith(instructor: value);
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
                                initialValue: initialValues['description'],
                                onSaved: (value) {
                                  _editedCourse = _editedCourse.copyWith(
                                      description: value);
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
                                initialValue: initialValues['hours'],
                                onSaved: (value) {
                                  _editedCourse = _editedCourse.copyWith(
                                      hours: int.parse(value!));
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
                                initialValue: initialValues['price'],
                                onSaved: (value) {
                                  _editedCourse = _editedCourse.copyWith(
                                      price: double.parse(value!));
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
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (_isUploading) ? null : _saveForm,
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(38, 231, 122, 1)),
                  minimumSize: MaterialStateProperty.all(
                    Size(deviceSize.height * 0.2, deviceSize.width * 0.04),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openPicker() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      final uploadedPdf = result.files.single.bytes;
      final loadedPdfName = result.files.single.name;
      setState(() {
        _isUploading = true;
      });
      Reference reference =
          FirebaseStorage.instance.ref().child('${Uuid().v1()}.pdf');
      final uploadTask = reference.putData(uploadedPdf!);

      uploadTask.whenComplete(() async {
        final pdf = await uploadTask.snapshot.ref.getDownloadURL();
        _editedCourse = _editedCourse.copyWith(pdfUrl: pdf);
        setState(() {
          _pdfName = loadedPdfName;
          _isUploading = false;
        });
      });
    }
  }
}
