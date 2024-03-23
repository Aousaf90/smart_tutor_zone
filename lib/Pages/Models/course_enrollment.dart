import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Courses/courseHelper.dart';

class CourseEnrollment {
  Student student = Student();
  enrollCourse(String course_id, String student_email) {
    // student_email = student.enrollStudent(course_id);
    // enrollStudentWithCourse(c);
    print("Course ID = ${course_id}");
  }
}
