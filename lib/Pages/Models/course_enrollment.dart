import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Courses/courseHelper.dart';

class CourseEnrollment {
  enrollCourse(String course_id, String student_email) {
    Student student_Model = Student();
    student_Model.enrollStudent(course_id);
  }
}
