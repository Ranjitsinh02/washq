class QuestionModel {
  bool? status;
  String? message;
  String? sectionName;
  List<QuestionData>? data;

  QuestionModel({this.status, this.message, this.sectionName, this.data});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    sectionName = json['section_name'];
    if (json['data'] != null) {
      data = <QuestionData>[];
      json['data'].forEach((v) {
        data!.add(QuestionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['section_name'] = sectionName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionData {
  String? queTitle;
  String? queId;
  List<QueOptions>? queOptions;

  QuestionData({this.queTitle, this.queId, this.queOptions});

  QuestionData.fromJson(Map<String, dynamic> json) {
    queTitle = json['que_title'];
    queId = json['que_id'];
    if (json['que_options'] != null) {
      queOptions = <QueOptions>[];
      json['que_options'].forEach((v) {
        queOptions!.add(QueOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['que_title'] = queTitle;
    data['que_id'] = queId;
    if (queOptions != null) {
      data['que_options'] = queOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueOptions {
  String? optionId;
  String? optionTitle;
  bool? isChecked = false;

  QueOptions({this.optionId, this.optionTitle, this.isChecked });

  QueOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionTitle = json['option_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['option_id'] = optionId;
    data['option_title'] = optionTitle;
    data['isChecked'] = data['isChecked'] != null ? isChecked : false;
    return data;
  }
}
