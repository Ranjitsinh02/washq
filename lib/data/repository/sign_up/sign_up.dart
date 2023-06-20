

import 'package:http/http.dart';
import 'package:washq/common_widget/network_handler.dart';

class SignUpRepository {

  NetworkHandler networkHandler = NetworkHandler();

  Future<StreamedResponse> getResponse(Map<String,String> fields) async {
    String endpoint = '/signup';

    var apiResponse = await networkHandler.getPostUrlencoded(endpoint,fields);
    if (apiResponse.statusCode == 200) {
      print("Signup Response:::$apiResponse");
      return apiResponse;
    } else {
      throw Exception('Failed to load dropdown data');
    }
  }
}