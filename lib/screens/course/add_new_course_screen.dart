import 'dart:io';
import 'dart:typed_data';

import 'package:dar_elkahrba/Models/course_model.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/providers/model_hud.dart';
import 'package:dar_elkahrba/widgets/course/add_course_custom_button.dart';
import 'package:dar_elkahrba/widgets/course/add_course_custom_text_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Constants.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({Key? key}) : super(key: key);

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController courseIdController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseInstructorController = TextEditingController();
  TextEditingController coursePriceController = TextEditingController();
  TextEditingController courseHoursController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  bool _isUploading = false;
  File? pdf;
  var _pdfName = '';
  String? _pdfName2;
  Store _store = Store();
  String uid = '';
  String coursePlace = "Chose Place";
  late int _value = 1;
  var _image;
  String courseImageUrl = '';

  void initState() {
    // TODO: implement initState
    super.initState();
    User? userAuth = FirebaseAuth.instance.currentUser;
    setState(() {
      uid = userAuth!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Course'),
        ),
        body: Center(
          child: Container(
            width: width * 0.7,
            padding: const EdgeInsets.all(20.0),
            // height: height * 0.8,
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                                width: height * 0.15,
                                height: height * 0.15,
                                child: _image == null
                                    ? Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.cloud_done,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                          _image == null
                              ? MaterialButton(
                                  padding: const EdgeInsets.all(15.0),
                                  onPressed: () {
                                    _imgFromGallery();
                                  },
                                  child: Text(
                                    'Click to Pick Photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  color: Colors.blueAccent,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                )
                              : courseImageUrl == ''
                                  ? MaterialButton(
                                      padding: const EdgeInsets.all(15.0),
                                      onPressed: () {
                                        uploadFile();
                                      },
                                      child: Text(
                                        'Upload Photo',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      color: Colors.blueAccent,
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    )
                                  : Container(),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AddCourseCustomTextFormField(
                              title: 'Course Name',
                              controller: courseNameController,
                            ),
                          ),
                          SizedBox(
                            width: height * 0.02,
                          ),
                          Expanded(
                            child: AddCourseCustomTextFormField(
                              title: 'Course Instructor',
                              controller: courseInstructorController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AddCourseCustomTextFormField(
                              title: 'Course Hours',
                              controller: courseHoursController,
                            ),
                          ),
                          SizedBox(
                            width: height * 0.02,
                          ),
                          Expanded(
                            child: AddCourseCustomTextFormField(
                              title: 'Course Price',
                              controller: coursePriceController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      AddCourseCustomTextFormField(
                        title: 'Course Description',
                        controller: courseDescriptionController,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            "Place",
                          ),
                          trailing: DropdownButton(
                            value: _value,
                            items: [
                              DropdownMenuItem(
                                enabled: false,
                                child: Text("Chose Place"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text(Constants.nasrCityPlace),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text(Constants.elMansouraPlace),
                                value: 3,
                              )
                            ],
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                                if (value == 1) {
                                  setState(() {
                                    coursePlace = "Chose Place";
                                  });
                                } else if (value == 2) {
                                  setState(() {
                                    coursePlace = Constants.nasrCityPlace;
                                  });
                                } else if (value == 3) {
                                  coursePlace = Constants.elMansouraPlace;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      (_isUploading)
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              width: width * 0.5,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0),
                                  onTap: _openPicker,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 20.0,
                                    ),
                                    leading: CircleAvatar(
                                      child: Text('PDF'),
                                    ),
                                    title: Center(
                                      child: Text(
                                        (_pdfName == '')
                                            ? 'Click to add course brochure'
                                            : _pdfName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    trailing: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      AddCourseCustomButton(
                        title: 'Add Course',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (_image != null && courseImageUrl != '') {
                              if (coursePlace == 'Chose Place') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "please chose place",
                                    ),
                                  ),
                                );
                              } else {
                                if (_pdfName2 != null) {
                                  _store.addCourse(
                                    context,
                                    CourseModel(
                                      courseName: courseNameController.text,
                                      courseHours: courseHoursController.text,
                                      coursePrice: coursePriceController.text,
                                      coursePdfUrl: _pdfName2,
                                      coursePlace: coursePlace,
                                      courseImageUrl: courseImageUrl,
                                      courseDescription:
                                          courseDescriptionController.text,
                                      courseInstructorName:
                                          courseInstructorController.text,
                                      courseAdminId: uid,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "please add pdf for this course",
                                      ),
                                    ),
                                  );
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "please add photo for this course",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
      Provider.of<ModelHud>(context, listen: false).isProgressLoading(true);
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
        Provider.of<ModelHud>(context, listen: false).isProgressLoading(false);
        final pdf = await uploadTask.snapshot.ref.getDownloadURL();
        setState(() {
          _pdfName = loadedPdfName;
          _pdfName2 = pdf;
          _isUploading = true;
        });
      }).whenComplete(() {
        _isUploading = false;
      });
    }
  }

  _imgFromGallery() async {
    Uint8List? fromPicker;
    fromPicker = (await ImagePickerWeb.getImage(outputType: ImageType.bytes))
        as Uint8List?;
    setState(() {
      _image = fromPicker;
    });
  }

  Future uploadFile() async {
    if (_image != null) {
      Provider.of<ModelHud>(context, listen: false).isProgressLoading(true);
      User? userAuth = FirebaseAuth.instance.currentUser;
      final feedStorage = FirebaseStorage.instanceFor();
      Reference refFeedBucket = feedStorage.ref().child('${Uuid().v1()}.png');

      var uploadedFile = await refFeedBucket.putData(_image);

      if (uploadedFile.state == TaskState.success) {
        String downloadUrl = '';
        downloadUrl = await refFeedBucket.getDownloadURL();
        Provider.of<ModelHud>(context, listen: false).isProgressLoading(false);
        setState(() {
          courseImageUrl = downloadUrl;
        });
      }
    }
  }
}
