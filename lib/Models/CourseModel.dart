class CourseModel {
  String? courseName;
  String? courseId;
  String? courseDescription;
  String? coursePdfUrl;
  String? courseInstructor;
  int? coursePrice;
  int? courseHours;

  CourseModel(
      this.courseName,
      this.courseId,
      this.courseDescription,
      this.coursePdfUrl,
      this.courseInstructor,
      this.coursePrice,
      this.courseHours);
}
