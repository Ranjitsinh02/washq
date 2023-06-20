import 'package:washq/data/model/hospital_type/hospital_type_model.dart';

import '../../../../common_widget/network_handler.dart';
import 'dart:convert' as convert;
import 'dart:convert';

class HospitalTypeRepository {

  NetworkHandler networkHandler = NetworkHandler();

  Future<List<HospitalTypeData>> fetchHospitalType() async {
    List<HospitalTypeData> hospitalNamedData = [];
    String endpoint = "/hospital_types";
    var apiResponse = await networkHandler.getAPI(endpoint);
    if (apiResponse.statusCode == 200) {
      var convertDataToJson = convert.jsonDecode(utf8.decode(apiResponse.bodyBytes));
      HospitalTypeModel hospitalNameList = HospitalTypeModel.fromJson(convertDataToJson);
      hospitalNameList.data?.forEach((element) {
        hospitalNamedData.add(element);
      });
      return hospitalNamedData;
    } else {
      throw Exception('Failed to load dropdown data');
    }
  }
}