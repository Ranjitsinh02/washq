import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_helper.dart';
import 'package:washq/data/model/hospital_name/hospital_name_model.dart';

import '../../../../data/repository/sign_up/hospital_name/hospital_name_repo.dart';
import 'hospital_name_event.dart';

part 'hospital_name_state.dart';

class HospitalNameBloc extends Bloc<HospitalNameEvent, HospitalNameState> {
  final HospitalNameRepository repository;
  List<String> hospitalName = [];

  List<HospitalNamedListData> hospitalList = [];
  String selectedValue = "Select Hospital";

  HospitalNameBloc({required this.repository}) : super(const HospitalNameInitial()) {

    on<HospitalNameEvent>((event, emit) => null);

    on<FetchHospitalName>((event, emit) async {
      try {
        hospitalList = await repository.fetchHospitalName();
        hospitalName.clear();
        hospitalName.add("Select Hospital");
        final hospitalNameData = hospitalList;
        for (var element in hospitalNameData) {
          hospitalName.add(element.hospitalName.toString());
        }
        if (kDebugMode) {
          print("inHomePage::: ${hospitalName.length}");
        }
          emit(HospitalNameSuccess(
              data: hospitalName, selectedValue: selectedValue));
          if (kDebugMode) {
            print("homeListsss::: ${hospitalList}");
          }

      } catch (e) {
        emit(HospitalNameFailed(error: e.toString()));
      }
    });

    on<SelectHospitalNameValue>((event, emit) {
      selectedValue = event.hospitalName;
      print("SelectedHospitalName:::::::$selectedValue");
      emit(HospitalNameSuccess(
          data: hospitalName, selectedValue: selectedValue));
    });
  }
}
