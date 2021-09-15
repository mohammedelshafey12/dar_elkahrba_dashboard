 import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Constants{


   static const String userPhoto = 'assets/authentication/userphoto.png';

   /// firebase Collections
   static const String adminCollection = 'AdminCollection';
   static const String usersCollection = 'UsersCollection';
   static const String doctorCollection = 'DoctorCollection';
   static const String courseCollection = 'CourseCollection';
   static const String myCoursesCollection = 'MyCoursesCollection';
   static const String coursesSessionCollection = 'CoursesSessionCollection';
   static const String coursesSessionStudentCollection = 'CoursesSessionStudentCollection';
   static const String courseVerifyCollection = 'CourseVerifyCollection';
   static const String courseStudentCollection = 'CourseStudentCollection';
   static const String studentCollection = 'StudentCollection';

   /// dar al kahrabaa places
   static const String nasrCityPlace = 'Nasr-City';
   static const String elMansouraPlace = 'El-Mansoura';

   /// Firebase Constants admin
   static const String adminId = 'AdminId';
   static const String adminName = 'AdminName';
   static const String adminEmail = 'AdminEmail';

   /// Firebase Constants doctor
   static const String doctorId = 'DoctorId';
   static const String doctorName = 'DoctorName';
   static const String doctorEmail = 'DoctorEmail';
   static const String doctorPhone = 'DoctorPhone';
   static const String doctorPlace = 'DoctorPlace';
   static const String doctorIsVerify = 'DoctorIsVerify';

   /// Firebase Constants user
   static const String userId = 'UserId';
   static const String userName = 'UserName';
   static const String userPhone = 'UserPhone';
   static const String userWhatsApp = 'UserWhatsApp';
   static const String userBirthDayDate = 'UserBirthDayDate';
   static const String userCity = 'UserCity';
   static const String userPlace = 'UserPlace';
   static const String userUniversity = 'UserUniversity';
   static const String userDepartment = 'UserDepartment';
   static const String userGender = 'UserGender';
   static const String userImageUrl = 'UserImageUrl';
   static const String userGovrenerate = 'UserGovrenerate';
   static const String userGraduationYear = 'UserGraduationYear';
   static const String userIsVerified = 'UserIsVerified';
   static const String userPhotoVerifiedUrl = 'UserPhotoVerifiedUrl';

   /// Firebase Constants course
   static const String courseId = 'CourseId';
   static const String courseName = 'CourseName';
   static const String coursePrice = 'CoursePrice';
   static const String coursePlace = 'CoursePlace';
   static const String courseHours = 'CourseHours';
   static const String courseDescription = 'CourseDescription';
   static const String coursePdfUrl = 'CoursePdfUrl';
   static const String courseAdminId = 'CourseAdminId';
   static const String courseInstructorName = 'CourseInstructorName';

   /// Firebase Constants course session
   static const String courseSessionName = 'CourseSessionName';
   static const String courseSessionDate = 'CourseSessionDate';

   /// photo url
   static const String logInPhoto = 'images/log_in_photo.jpg';
   static const String signUpPhoto = 'images/sign_up_photo.jpg';

   /// method navigate page
   static void navigatorPush({context, screen}) {
      Navigator.push(
         context,
         PageTransition(
            type: PageTransitionType.fade,
            child: screen,
         ),
      );
   }
   /// method navigate and remove page
   static void navigatorPushAndRemove({context, screen}) {
      Navigator.pushAndRemoveUntil(
         context,
         PageTransition(
            type: PageTransitionType.fade,
            child: screen,
         ),
             (route) => false,
      );
   }
 }