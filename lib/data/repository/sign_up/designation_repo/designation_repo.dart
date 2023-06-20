import 'package:washq/data/model/designation/designation_model.dart';
import 'dart:convert';
import 'dart:convert' as convert;

import '../../../../common_widget/network_handler.dart';


class DesignationRepository {
  NetworkHandler networkHandler = NetworkHandler();

  Future<List<DesignationData>> getDesignation() async {
    List<DesignationData> designationData = [];
    String endpoint = '/designation';

    var apiResponse = await networkHandler.getAPI(endpoint);

    if (apiResponse.statusCode == 200) {
      var convertDartToJson =
      convert.jsonDecode(utf8.decode(apiResponse.bodyBytes));
      DesignationModel departmentData = DesignationModel.fromJson(convertDartToJson);
      departmentData.data?.forEach((element) {
        designationData.add(element);
      });
    } else {
      throw Exception('Failed to load dropdown data');
    }
    return designationData;
  }
}
