import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:washq/common_widget/app_helper.dart';

import 'my_exception.dart';

class NetworkHandler {
  NetworkHandler();

  String baseUrl = "https://washcheck.hyunixsolutions.com/washcheck";
  String apiSuffix = '/Api';

  Future<Map<String, String>> headers() async {
    String token = await AppHelper.getToken();

    print("Token in Network:::$token");
    if (token.isNotEmpty) {
      return {
        "content-type": "application/json; charset=UTF-8",
        "authorization": token,
      };
    } else {
      return {
        "content-type": "application/json; charset=UTF-8",
      };
    }
  }



  Future<http.Response> getAPI(String endpoint) async {
    try {
      var uri = Uri.parse(baseUrl + apiSuffix + endpoint);
      if (kDebugMode) {
        print("URl:::$uri");
      }
      var response = await http.get(uri, headers: await headers());

      return response;
    } catch (e) {
      throw MyException(e);
    }
  }

  Future<StreamedResponse> getPostUrlencoded(
      String endpoint, Map<String, String> fields) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = await http.Request('POST', Uri.parse(baseUrl + apiSuffix + endpoint));
    request.bodyFields = fields;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  // Login APi

  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    final response =
        await http.post(Uri.parse(baseUrl + apiSuffix + endPoint), body: body);
    return response;
  }

  Future<http.Response> postRequest(String endpoint,
      {Map<String, dynamic>? parameters}) async {
    String token = await AppHelper.getToken();
    print("Token::${token}");
    try {
      var url = Uri.parse(baseUrl + apiSuffix + endpoint);
      var response = await http.post(url,
          headers: {
            "authorization": token,
          },
          body: parameters,);
      return response;
    } catch (e) {
      throw MyException(e);
    }
  }

  Future<http.Response> postReq(String endpoint,
      {required Map<String, dynamic> body}) async {
    String token = await AppHelper.getToken();
    print("Token::${token}");
    try {
      var url = Uri.parse(baseUrl + apiSuffix + endpoint);
      var response = await http.post(url,
        headers: {
          "authorization": token,
        },
        body: jsonEncode(body),);
      return response;
    } catch (e) {
      print("Error${e.toString()}");
      throw MyException(e);
    }
  }
  Future<http.Response> getRequest(String endpoint,
      {Map<String, String>? queryParameter}) async {
    try {
      var uri = Uri.https(baseUrl, apiSuffix + endpoint, queryParameter);
      var response = await http.get(uri, headers: await headers());
      return response;
    } catch (e) {
      throw MyException(e);
    }
  }
}
