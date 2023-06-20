class UserProfileModel {
  bool? status;
  String? message;
  List<UserProfileData>? data;

  UserProfileModel({this.status, this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserProfileData>[];
      json['data'].forEach((v) {
        data!.add(UserProfileData.fromJson(v));
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

class UserProfileData {
  String? userId;
  String? userName;
  String? userPhone;
  String? userEmail;
  String? userHospital;
  String? userHospitalType;
  String? userHospitalDepartment;
  String? userHospitalDesignation;

  UserProfileData(
      {this.userId,
        this.userName,
        this.userPhone,
        this.userEmail,
        this.userHospital,
        this.userHospitalType,
        this.userHospitalDepartment,
        this.userHospitalDesignation});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    userEmail = json['user_email'];
    userHospital = json['user_hospital'];
    userHospitalType = json['user_hospital_type'];
    userHospitalDepartment = json['user_hospital_department'];
    userHospitalDesignation = json['user_hospital_designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_phone'] = userPhone;
    data['user_email'] = userEmail;
    data['user_hospital'] = userHospital;
    data['user_hospital_type'] = userHospitalType;
    data['user_hospital_department'] = userHospitalDepartment;
    data['user_hospital_designation'] = userHospitalDesignation;
    return data;
  }
}
