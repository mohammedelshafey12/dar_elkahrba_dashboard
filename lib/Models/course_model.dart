class CourseModel {
  String? courseName;
  String? courseHours;
  String? coursePlace;
  String? coursePrice;
  String? coursePdfUrl;
  String? courseDescription;
  String? courseAdminId;
  String? courseInstructorName;

  CourseModel({
    required this.courseName,
    required this.courseDescription,
    required this.coursePdfUrl,
    required this.coursePlace,
    required this.coursePrice,
    required this.courseHours,
    required this.courseAdminId,
    required this.courseInstructorName,
  });
}
