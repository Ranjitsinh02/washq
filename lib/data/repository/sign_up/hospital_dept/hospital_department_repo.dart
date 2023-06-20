import 'dart:convert';
import 'dart:convert' as convert;

import 'package:washq/common_widget/network_handler.dart';

import '../../../model/hospital_dept/hospital_department.dart';

class HospitalDepartmentRepository {
  NetworkHandler networkHandler = NetworkHandler();

  Future<List<HospitalDepartmentData>> getHospitalDepartment() async {
    List<HospitalDepartmentData> hospitalDeptData = [];
    String endpoint = '/departments';

    var apiResponse = await networkHandler.getAPI(endpoint);

    if (apiResponse.statusCode == 200) {
      var convertDartToJson =
          convert.jsonDecode(utf8.decode(apiResponse.bodyBytes));
      HospitalDepartmentModel departmentData =
          HospitalDepartmentModel.fromJson(convertDartToJson);
      departmentData.data?.forEach((element) {
        hospitalDeptData.add(element);
      });
    } else {
      throw Exception('Failed to load dropdown data');
    }
    return hospitalDeptData;
  }
}
