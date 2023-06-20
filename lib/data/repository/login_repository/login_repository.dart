import 'package:washq/common_widget/network_handler.dart';

class LoginRepository {
  NetworkHandler networkHandler = NetworkHandler();

  Future<dynamic> loginRequest(Map<String, dynamic> body) async {
    String endpoint = '/login';

    var apiResponse = await networkHandler.post(endpoint, body);

    return apiResponse;
    /* if (apiResponse.statusCode == 200) {
     */ /* var convertDartToJson =
      convert.jsonDecode(utf8.decode(apiResponse.bodyBytes));
      UserModel userData =
      UserModel.fromJson(convertDartToJson);*/ /*

    } else {
      throw Exception('Failed to load dropdown data');
    }*/
  }

  Future<dynamic> forgotPassword(Map<String, dynamic> body) async {
    String endpoint = '/forgot_password';

    var apiResponse = await networkHandler.post(endpoint, body);
    return apiResponse;
  }

  Future<dynamic> verifyOtp(Map<String, dynamic> body) async {
    String endpoint = '/verify_reset_code';

    var apiResponse = await networkHandler.post(endpoint, body);
    return apiResponse;
  }

  Future<dynamic> resetPassword(Map<String, dynamic> body) async {
    String endpoint = '/reset_password';

    var apiResponse = await networkHandler.post(endpoint, body);
    return apiResponse;
  }
}
