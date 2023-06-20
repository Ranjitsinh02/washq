class HospitalNameModel {
  bool? status;
  String? message;
  List<HospitalNamedListData>? data;

  HospitalNameModel({this.status, this.message, this.data});

  HospitalNameModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HospitalNamedListData>[];
      json['data'].forEach((v) {
        data!.add(HospitalNamedListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HospitalNamedListData {
  String? hospitalId;
  String? hospitalName;
  String? hospitalType;
  String? hospitalAddress;
  String? hospitalCountry;
  String? hospitalState;
  String? hospitalCity;
  String? hospitalArea;
  String? hospitalZipcode;
  String? hospitalFile;
  String? hospitalTotalSurvey;
  String? hospitalContactNo;
  String? hospitalStatus;
  String? createdAt;
  String? updatedAt;
  String? isDeleted;

  HospitalNamedListData(
      {this.hospitalId,
        this.hospitalName,
        this.hospitalType,
        this.hospitalAddress,
        this.hospitalCountry,
        this.hospitalState,
        this.hospitalCity,
        this.hospitalArea,
        this.hospitalZipcode,
        this.hospitalFile,
        this.hospitalTotalSurvey,
        this.hospitalContactNo,
        this.hospitalStatus,
        this.createdAt,
        this.updatedAt,
        this.isDeleted});

  HospitalNamedListData.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'];
    hospitalName = json['hospital_name'];
    hospitalType = json['hospital_type'];
    hospitalAddress = json['hospital_address'];
    hospitalCountry = json['hospital_country'];
    hospitalState = json['hospital_state'];
    hospitalCity = json['hospital_city'];
    hospitalArea = json['hospital_area'];
    hospitalZipcode = json['hospital_zipcode'];
    hospitalFile = json['hospital_file'];
    hospitalTotalSurvey = json['hospital_total_survey'];
    hospitalContactNo = json['hospital_contact_no'];
    hospitalStatus = json['hospital_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hospital_id'] = hospitalId;
    data['hospital_name'] = hospitalName;
    data['hospital_type'] = hospitalType;
    data['hospital_address'] = hospitalAddress;
    data['hospital_country'] = hospitalCountry;
    data['hospital_state'] = hospitalState;
    data['hospital_city'] = hospitalCity;
    data['hospital_area'] = hospitalArea;
    data['hospital_zipcode'] = hospitalZipcode;
    data['hospital_file'] = hospitalFile;
    data['hospital_total_survey'] = hospitalTotalSurvey;
    data['hospital_contact_no'] = hospitalContactNo;
    data['hospital_status'] = hospitalStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
