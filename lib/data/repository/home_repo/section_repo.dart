import 'dart:core';

import 'package:http/http.dart';
import 'package:washq/common_widget/network_handler.dart';

class SectionRepository {
  NetworkHandler networkHandler = NetworkHandler();

  Future<Response> getSection(String token) async {
    String endPoint = '/get_sections';

    var response = await networkHandler.getAPI(endPoint);

    return response;
  }

  Future<Response> submitAnswer(Map<String, dynamic> body) async {
    String endPoint = '/submit_answer';

    var response = await networkHandler.postReq(endPoint, body: body);
    return response;
  }
}
