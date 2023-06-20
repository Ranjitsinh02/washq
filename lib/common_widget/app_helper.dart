import 'package:shared_preferences/shared_preferences.dart';

class AppHelper {
  // late SharedPreferences prefs;
  static void clearSharePres()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.clear();
  }

  static void setToken(String topic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cognitoToken', topic);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cognitoToken') ?? "";
  }

  static void setHospitalType(String hospitalType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('hospitalType', hospitalType);
  }

  static Future<String> getHospitalType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('hospitalType') ?? "";
  }

  static void setUserLoginStatus(bool loginStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (!loginStatus) {
    //   // FirebaseMessaging messaging = FirebaseMessaging.instance;
    //   // messaging.deleteToken();
    // }
    prefs.setBool('loginStatus', loginStatus);
  }

  static Future<bool> getUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loginStatus = prefs.getBool('loginStatus') ?? false;
    return loginStatus;
  }

  static void setHospitalId(String hospitalId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('hospitalId', hospitalId);
  }

  static Future<String> getHospitalId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('hospitalId') ?? "";
  }
  static void setHospitalDepartment(String hospitalDepartment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('hospitalDepartment', hospitalDepartment);
  }

  static Future<String> getHospitalDepartment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('hospitalDepartment') ?? "";
  }
}
