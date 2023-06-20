import 'dart:convert';
import 'dart:convert' as convert;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_helper.dart';
import 'package:washq/data/model/question_model/question_model.dart';
import 'package:washq/data/repository/question_repo/question_repo.dart';

part 'question_event.dart';

part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepository repository;

  QuestionBloc({required this.repository}) : super(QuestionInitial()) {
    List<QuestionData> _questions = [];
    List<QueOptions> _options = [];
    QuestionModel model = QuestionModel();
    on<SectionStartButtonPressed>((event, emit) async {
      emit(QuestionLoading());
      String hospitalType = await AppHelper.getHospitalType();
      print("QuestionBloc hospital_type:::$hospitalType");
      print("QuestionBloc section_id:::${event.hospitalId}");

      Map<String, dynamic> body = {
        "section_id": event.hospitalId,
        "hospital_type": "1",
      };
      try {
        var response = await repository.getQuestions(body);
        if (response.statusCode == 200) {
          var convertDartToJson =
              await convert.jsonDecode(utf8.decode(response.bodyBytes));
          model = QuestionModel.fromJson(convertDartToJson);
          // model.data?.add(model.data!.first);
          /*model.data?.forEach((element) { print(element.queTitle);
            _questions.add(element.queTitle)
          element.queOptions?.forEach((element) { print("Options::${element.optionTitle}");});});*/
          emit(QuestionLoaded(questionModel: model));
        }
      } catch (e) {
        print(e.toString());
        emit(QuestionError(error: e.toString()));
      }
    });
  }
}
