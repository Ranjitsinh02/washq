class HospitalDepartmentModel {
  bool? status;
  String? message;
  List<HospitalDepartmentData>? data;

  HospitalDepartmentModel({this.status, this.message, this.data});

  HospitalDepartmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HospitalDepartmentData>[];
      json['data'].forEach((v) {
        data!.add(HospitalDepartmentData.fromJson(v));
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

class HospitalDepartmentData {
  String? departmentId;
  String? departmentName;
  String? createdAt;
  String? updatedAt;
  String? isDeleted;

  HospitalDepartmentData(
      {this.departmentId,
        this.departmentName,
        this.createdAt,
        this.updatedAt,
        this.isDeleted});

  HospitalDepartmentData.fromJson(Map<String, dynamic> json) {
    departmentId = json['department_id'];
    departmentName = json['department_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['department_id'] = departmentId;
    data['department_name'] = departmentName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
