import 'dart:convert';
import 'dart:convert' as convert;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_helper.dart';
import 'package:washq/data/model/section_model/section_model.dart';
import 'package:washq/data/repository/home_repo/section_repo.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<SectionData> sectionDataList = [];
  final SectionRepository repository;

  // final QuestionBloc questionBloc;

  /* void selectedSection(String hospitalId, String hospitalType) {
    add(SectionStartButtonPressed(hospitalId: '', hospitalType: ''));
  }*/

  HomeBloc({required this.repository /*,required this.questionBloc*/
      })
      : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        String token = await AppHelper.getToken();
        if (kDebugMode) {
          print("SectionBlocToken::::$token");
        }
        var response = await repository.getSection(token);
        if (response.statusCode == 200) {
          var convertDartToJson =
              convert.jsonDecode(utf8.decode(response.bodyBytes));
          SectionModel sectionData = SectionModel.fromJson(convertDartToJson);
          sectionData.data?.forEach((element) {
            sectionDataList.add(element);
          });
          emit(HomeLoaded(data: sectionDataList));
          if (kDebugMode) {
            print("SectionDataInBloc::${sectionDataList.first.sectionName}");
            print("SectionDataInBloc::${sectionDataList.first.sectionId}");
          }
        } else {
          throw Exception('Failed to load dropdown data');
        }
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });

    on<OnSubmitQuestionAnswer>((event, emit) {
      Map<String, dynamic> body = {
        "survey_hospital": "1",
        "survey_department": "1",
        "submit_answer": event.questionAnswer
      };
      print("OnSubmit:::$body");
        var response = repository.submitAnswer(body);

      print("response:::${response}");
      
    });
  }
}
