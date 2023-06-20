class UserModel {
  String? userEmailId;
  String? password;

  UserModel({this.userEmailId, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    userEmailId = json['userEmailId'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userEmailId'] = userEmailId;
    data['password'] = password;
    return data;
  }
}