class DesignationModel {
  bool? status;
  String? message;
  List<DesignationData>? data;

  DesignationModel({this.status, this.message, this.data});

  DesignationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DesignationData>[];
      json['data'].forEach((v) {
        data!.add(DesignationData.fromJson(v));
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

class DesignationData {
  String? designationId;
  String? designationName;
  String? createdAt;
  String? updatedAt;
  String? isDeleted;

  DesignationData(
      {this.designationId,
        this.designationName,
        this.createdAt,
        this.updatedAt,
        this.isDeleted});

  DesignationData.fromJson(Map<String, dynamic> json) {
    designationId = json['designation_id'];
    designationName = json['designation_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['designation_id'] = designationId;
    data['designation_name'] = designationName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
