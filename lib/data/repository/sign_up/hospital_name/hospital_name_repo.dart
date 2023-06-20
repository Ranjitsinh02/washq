import 'dart:convert' as convert;
import 'dart:convert';

import 'package:washq/common_widget/network_handler.dart';

import '../../../model/hospital_name/hospital_name_model.dart';

class HospitalNameRepository {

  NetworkHandler networkHandler = NetworkHandler();

  Future<List<HospitalNamedListData>> fetchHospitalName() async {
    List<HospitalNamedListData> hospitalNamedData = [];
    String endpoint = "/hospitals";
    var apiResponse = await networkHandler.getAPI(endpoint);
    if (apiResponse.statusCode == 200) {
      var convertDataToJson =
      convert.jsonDecode(utf8.decode(apiResponse.bodyBytes));
      HospitalNameModel hospitalNameList = HospitalNameModel.fromJson(convertDataToJson);
      hospitalNameList.data?.forEach((element) {
        hospitalNamedData.add(element);
      });
      return hospitalNamedData;
    } else {
      throw Exception('Failed to load dropdown data');
    }
  }
}
