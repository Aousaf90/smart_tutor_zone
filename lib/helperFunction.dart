import 'package:shared_preferences/shared_preferences.dart';

class helperFunction {
  static String userLoginStatus = "loginStatus";
  static String nameID = "nameID";
  static String emailID = "emailID";
  static String EducationID = "educationID";

  static Future<bool> saveUserLogInStatus(loginStatus) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setBool(userLoginStatus, loginStatus);
  }

  // static Future<bool> saveStudentName(studentName) async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   return sf.setString(nameID, studentName);
  // }

  static Future<bool> saveStudentEmail(studentEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(emailID, studentEmail);
  }

  // static Future<bool> saveStudentEducation(studentEducation) async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   return sf.setString(EducationID, studentEducation);
  // }

  static Future<bool?> getloginStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoginStatus);
  }

  // static Future<String?> getStudentName() async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   return sf.getString(nameID);
  // }

  static Future<String?> getStudentEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(emailID);
  }

  // static Future<String?> getStudentEducation() async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   return sf.getString(EducationID);
  // }

  static Future<void> deleteStudentData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setBool(userLoginStatus, false);
    sf.remove(emailID);
  }
}
