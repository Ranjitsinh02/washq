class HospitalTypeModel {
  bool? status;
  String? message;
  List<HospitalTypeData>? data;

  HospitalTypeModel({this.status, this.message, this.data});

  HospitalTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HospitalTypeData>[];
      json['data'].forEach((v) {
        data!.add(HospitalTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HospitalTypeData {
  String? hospitalTypeId;
  String? hospitalTypeName;
  String? createdAt;
  String? updatedAt;
  String? isDeleted;

  HospitalTypeData(
      {this.hospitalTypeId,
        this.hospitalTypeName,
        this.createdAt,
        this.updatedAt,
        this.isDeleted});

  HospitalTypeData.fromJson(Map<String, dynamic> json) {
    hospitalTypeId = json['hospital_type_id'];
    hospitalTypeName = json['hospital_type_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hospital_type_id'] = hospitalTypeId;
    data['hospital_type_name'] = hospitalTypeName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
