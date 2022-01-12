import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/Models/course_model.dart';
import 'package:dar_elkahrba/Models/admin_model.dart';
import 'package:dar_elkahrba/Models/course_session_model.dart';
import 'package:dar_elkahrba/screens/course/course_session_home_screen.dart';
import 'package:dar_elkahrba/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Store {

  /// object from FirebaseFirestore
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// After Sign up Update User Information In Firebase Firestore
  addAdmin(AdminModel admin) {
    fireStore.collection(Constants.adminCollection).doc(admin.adminId).set({
      Constants.adminId: admin.adminId,
      Constants.adminName: admin.adminName,
      Constants.adminEmail: admin.adminEmail
    });
  }

  /// add course for doctor
  addCourse(context, CourseModel course) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Loading ...'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
    var courseDoc =  fireStore.collection(Constants.courseCollection).doc();
    var courseRev = courseDoc.id;
    courseDoc.set({
      Constants.courseId : courseRev,
      Constants.courseName: course.courseName,
      Constants.courseImageUrl: course.courseImageUrl,
      Constants.coursePlace: course.coursePlace,
      Constants.courseInstructorName: course.courseInstructorName,
      Constants.courseHours: course.courseHours,
      Constants.coursePrice: course.coursePrice,
      Constants.coursePdfUrl: course.coursePdfUrl,
      Constants.courseDescription: course.courseDescription,
      Constants.courseAdminId: course.courseAdminId,
    }).whenComplete(() {
      Constants.navigatorPushAndRemove(
        context: context,
        screen: HomeScreen(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Course added successfully",
            style: TextStyle(
              fontFamily: 'custom_Font',
            ),
          ),
        ),
      );
    });
  }


  /// add session for course
  addNewSession({
    required context,
    required CourseSessionModel session,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Loading ...'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
    fireStore
        .collection(Constants.courseCollection)
        .doc(session.courseId)
        .collection(Constants.coursesSessionCollection)
        .doc(session.courseSessionDate)
        .set({
      Constants.courseSessionName: session.courseSessionName,
      Constants.courseSessionDate: session.courseSessionDate,
    }).whenComplete(() {
      Constants.navigatorPush(
        context: context,
        screen: CourseSessionHomeScreen(
          courseId: session.courseId,
          sessionName: session.courseSessionName,
          sessionDate: session.courseSessionDate,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Session added successfully",
            style: TextStyle(
              fontFamily: 'custom_Font',
            ),
          ),
        ),
      );
    });
  }

 Future refuseUser ({
    required String userId,

  }) async{

    await fireStore
        .collection(Constants.usersCollection)
        .doc(userId)
        .update({
      Constants.userPhotoVerifiedUrl:null,

    });

  }


  verifyUser({
    required String userId,
    required String userName,
    required String courseId,
    required String courseName,
  }) {
    fireStore.collection(Constants.usersCollection).doc(userId).update({
      Constants.userIsVerified: true,
    });
    fireStore
        .collection(Constants.usersCollection)
        .doc(userId)
        .collection(Constants.myCoursesCollection)
        .doc(courseId)
        .set({
      Constants.courseId: courseId,
      Constants.courseName: courseName,
    });
    courseStudent(
      courseId: courseId,
      courseName: courseName,
      userId: userId,
      userName: userName,
    );
  }

  verifyDoctor({
    required String doctorId,
  }) {
    fireStore.collection(Constants.doctorCollection).doc(doctorId).update({
      Constants.doctorIsVerify: true,
    });
  }

  verifyCourse({
    required String userId,
    required String userName,
    required courseId,
    required courseName,
    required docId,
  }) {
    fireStore
        .collection(Constants.usersCollection)
        .doc(userId)
        .collection(Constants.myCoursesCollection)
        .doc(courseId)
        .set({
      Constants.courseId: courseId,
      Constants.courseName: courseName,
    });
    courseStudent(
      courseId: courseId,
      courseName: courseName,
      userId: userId,
      userName: userName,
    );
    deleteDoc(docId);
  }

  void courseStudent({
    required userId,
    required userName,
    required courseId,
    required courseName,
  }) {
    fireStore
        .collection(Constants.courseStudentCollection)
        .doc(courseId)
        .collection(Constants.studentCollection)
        .doc(userId)
        .set({
      Constants.userId: userId,
      Constants.userName: userName,
      Constants.courseId: courseId,
      Constants.courseName: courseName,
    });
  }

  /// delete course
  Future deleteCourse({
    required courseId,
    required context
  }) async {
    final courseSessions =await fireStore
        .collection(Constants.courseCollection)
        .doc(courseId)
        .collection(Constants.coursesSessionCollection).get();
    if (courseSessions.docs.isNotEmpty){
      fireStore
          .collection(Constants.courseCollection)
          .doc(courseId)
          .collection(Constants.coursesSessionCollection)
          .get()
          .then(
            (snapshot) async{
              for (DocumentSnapshot i in snapshot.docs) {
                final courseSseionStudentCollection = await fireStore
                    .collection(Constants.courseCollection)
                    .doc(courseId)
                    .collection(Constants.coursesSessionCollection)
                    .doc(i.id)
                    .collection(Constants.coursesSessionStudentCollection)
                    .get();
                if(courseSseionStudentCollection.docs.isNotEmpty){
                  fireStore
                      .collection(Constants.courseCollection)
                      .doc(courseId)
                      .collection(Constants.coursesSessionCollection)
                      .doc(i.id)
                      .collection(Constants.coursesSessionStudentCollection)
                      .get()
                      .then(
                        (snapshot) {
                      for (DocumentSnapshot j in snapshot.docs) {
                        j.reference.delete();
                      }
                    },
                  ).whenComplete(
                        () {
                      fireStore.collection(Constants.courseStudentCollection).doc(courseId).delete();
                    },
                  );
                } else{
                  fireStore
                      .collection(Constants.courseCollection)
                      .doc(courseId)
                      .collection(Constants.coursesSessionCollection)
                      .get()
                      .then(
                        (snapshot) {
                      for (DocumentSnapshot i in snapshot.docs) {
                        i.reference.delete();
                      }
                    },
                  ).whenComplete(
                        () {
                          fireStore.collection(Constants.courseCollection).doc(courseId).delete();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Course deleted")))  ;
                    },
                  );
                }
              }
        },
      );
    } else{
      fireStore.collection(Constants.courseCollection).doc(courseId).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Course deleted")))  ;
    }

    fireStore
        .collection(Constants.courseStudentCollection)
        .doc(courseId)
        .get().whenComplete((){
      var coursesSessionCollection =  fireStore
          .collection(Constants.courseCollection)
          .doc(courseId)
          .collection(Constants.coursesSessionCollection).doc();
      if(coursesSessionCollection!= null){
        fireStore
            .collection(Constants.courseCollection)
            .doc(courseId)
            .collection(Constants.coursesSessionCollection)
            .get().then(
              (snapshot) {
            fireStore
                .collection(Constants.courseStudentCollection)
                .doc(courseId)
                .collection(Constants.studentCollection)
                .get()
                .then(
                  (snapshot) {
                for (DocumentSnapshot j in snapshot.docs) {
                  j.reference.delete();
                }
              },
            ).whenComplete(
                  () {
                fireStore.collection(Constants.courseStudentCollection).doc(courseId).delete();
              },
            );

          },
        );
      }
      else{
        fireStore.collection(Constants.courseStudentCollection).doc(courseId).delete();
      }

    });
    User? userAuth = FirebaseAuth.instance.currentUser;
    var coursesStudentCollection =  fireStore
        .collection(Constants.usersCollection)
        .where(Constants.userIsVerified , isEqualTo: true).firestore
        .collection(Constants.myCoursesCollection).doc();
    if(coursesStudentCollection!=null){
          fireStore
          .collection(Constants.usersCollection)
          ..where(Constants.userIsVerified , isEqualTo: true).firestore
          .collection(Constants.myCoursesCollection).doc(courseId).delete();
    }


  }

  void deleteDoc(docId) {
    fireStore.collection(Constants.courseVerifyCollection).doc(docId).delete();
  }

  getUser(String userId) {
    fireStore.collection("UsersCollection").doc(userId).snapshots();
  }

  Stream<QuerySnapshot> userDataVerfied() {
    return fireStore
        .collection("UsersCollection")
        .where(Constants.userIsVerified, isEqualTo: false)
        .where(Constants.userPhotoVerifiedUrl, isNotEqualTo: null)
        .snapshots();
  }

  Stream<QuerySnapshot> courseVerifyStudent({
    required String courseId,
  }) {
    return fireStore
        .collection("CourseVerifyCollection")
        .where('CourseId', isEqualTo: courseId)
        .snapshots();
  }
//  Stream<QuerySnapshot> userData (String uid){
//   return firestore.collection(Constants.usersCollection).where(Constants.userId ,isEqualTo: uid).snapshots();
// }

}
