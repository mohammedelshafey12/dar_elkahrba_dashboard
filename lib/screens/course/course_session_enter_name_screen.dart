import 'package:dar_elkahrba/Models/course_session_model.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/widgets/dialog_do_you_want.dart';
import 'package:flutter/material.dart';

class CourseSessionEnterNameScreen extends StatelessWidget {
  const CourseSessionEnterNameScreen({
    Key? key,
    required this.courseId,
  });

  final courseId;

  @override
  Widget build(BuildContext context) {
    TextEditingController sessionNameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Store _store = Store();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Session',
        ),
      ),
      body: Center(
        child: Container(
          width: width * 0.8,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: sessionNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Session Name must be not empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Session Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        color: Colors.blue,
                      ),
                      width: width,
                      height: 50.0,
                      child: MaterialButton(
                        height: 50.0,
                        child: Text(
                          'Add Session Now',
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          String dateNow = DateTime.now().toString();
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) => DialogDoYouWant(
                                title: 'Do you want to add new session?',
                                onTapYes: () {
                                  _store.addNewSession(
                                    context: context,
                                    session: CourseSessionModel(
                                      courseId: courseId,
                                      courseSessionName: sessionNameController.text,
                                      courseSessionDate: dateNow,
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
