import 'dart:convert';

import 'package:http/http.dart';
import 'package:washq/common_widget/network_handler.dart';

class UserProfileRepo{
  NetworkHandler networkHandler = NetworkHandler();

  Future<Response> getUserProfile(String token) async {
    String endPoint = '/get_profile';

    var response = await networkHandler.postRequest(endPoint);

    return response;
  }
}