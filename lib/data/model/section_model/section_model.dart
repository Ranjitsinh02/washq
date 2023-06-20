class SectionModel {
  bool? status;
  String? message;
  List<SectionData>? data;

  SectionModel({this.status, this.message, this.data});

  SectionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SectionData>[];
      json['data'].forEach((v) {
        data!.add(SectionData.fromJson(v));
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

class SectionData {
  String? sectionId;
  String? sectionName;

  SectionData({this.sectionId, this.sectionName});

  SectionData.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'];
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['section_id'] = sectionId;
    data['section_name'] = sectionName;
    return data;
  }
}
