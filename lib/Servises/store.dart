import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dar_elkahrba/Constants.dart';
import 'package:dar_elkahrba/Models/CourseModel.dart';
import 'package:dar_elkahrba/Models/UserModel.dart';
import 'package:dar_elkahrba/providers/modelHud.dart';
import 'package:dar_elkahrba/screens/qr/sessions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Store {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// After Sign in Update User Information In Firebase Firestore
  adduser(UserModel user) {
    firestore.collection(Constants.usersCollection).doc(user.userId).set({
      Constants.userName: user.userName,
      Constants.userId: user.userId,
      Constants.userIsAdmin: user.isAdmin
    });
  }

  /// add new course
  addCourse(CourseModel courseModel, context) {
    firestore
        .collection(Constants.courseCollection)
        .doc(
          courseModel.courseId,
        )
        .set({
      Constants.courseName: courseModel.courseName,
      Constants.courseDesc: courseModel.courseDescription,
      Constants.courseInstructor: courseModel.courseInstructor,
      Constants.courseId: courseModel.courseId,
      Constants.coursePrice: courseModel.coursePrice,
      Constants.courseHours: courseModel.courseHours,
      Constants.coursePdfUrl: courseModel.coursePdfUrl
    });
  }

  /// add new session to course
  addNewSession(String docId, String date, BuildContext context) {
    firestore
        .collection(Constants.courseCollection)
        .doc(docId)
        .collection(Constants.coursesSessionCollection)
        .doc(date)
        .set({"SessionId": date}).whenComplete(
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SessionScreen(
            date: date,
            courseId: docId,
          ),
        ),
      ),
    );
  }

  verifyUser({
    required String userId,
    required String userName,
    required String courseId,
    required String courseName,
  }) {
    firestore
        .collection("UsersCollection")
        .doc(userId)
        .update({Constants.userIsVerified: true});
    firestore
        .collection("UsersCollection")
        .doc(userId)
        .collection('MyCourses')
        .doc(courseId)
        .set({
      'CourseId': courseId,
      'CourseName': courseName,
    });
    courseStudent(
      courseId: courseId,
      courseName: courseName,
      userId: userId,
      userName: userName,
    );
  }

  verifyCourse({
    required String userId,
    required String userName,
    required courseId,
    required courseName,
    required docId,
  }) {
    firestore
        .collection("UsersCollection")
        .doc(userId)
        .collection('MyCourses')
        .doc(courseId)
        .set({
      'CourseId': courseId,
      'CourseName': courseName,
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
    firestore
        .collection("CourseStudentCollection")
        .doc(courseId)
        .collection('StudentCollection')
        .doc(userId)
        .set({
      'UserId': userId,
      'UserName': userName,
      'CourseId': courseId,
      'CourseName': courseName,
    });
  }

  void deleteDoc(docId) {
    firestore.collection("CourseVerifyCollection").doc(docId).delete();
  }

  getUser(String userId) {
    firestore.collection("UsersCollection").doc(userId).snapshots();
  }

  Stream<QuerySnapshot> userDataVerfied() {
    return firestore
        .collection("UsersCollection")
        .where(Constants.userIsVerified, isEqualTo: false)
        .where(Constants.userPhotoVerifiedUrl, isNotEqualTo: null)
        .snapshots();
  }

  Stream<QuerySnapshot> courseVerifyStudent({
    required String courseId,
  }) {
    return firestore
        .collection("CourseVerifyCollection")
        .where('CourseId', isEqualTo: courseId)
        .snapshots();
  }
//  Stream<QuerySnapshot> userData (String uid){
//   return firestore.collection(Constants.usersCollection).where(Constants.userId ,isEqualTo: uid).snapshots();
// }

}
