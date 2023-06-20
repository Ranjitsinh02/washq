import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/hospital_type/hospital_type_model.dart';
import '../../../../data/repository/sign_up/hospital_type/hospital_type_repo.dart';

part 'hospital_type_event.dart';

part 'hospital_type_state.dart';

class HospitalTypeBloc extends Bloc<HospitalTypeEvent, HospitalTypeState> {
  final HospitalTypeRepository repository;
  List<String> hospitalTypeList = [];
  List<HospitalTypeData> hospitalTypeDataList = [];

  String selectedType = "Select HospitalType";
  HospitalTypeBloc({required this.repository}) : super(HospitalTypeInitial()) {

    on<FetchHospitalTypeEvent>((event, emit) async {
      emit(HospitalTypeLoading());
      try {
        hospitalTypeDataList = await repository.fetchHospitalType();
        hospitalTypeList.clear();
        hospitalTypeList.add("Select HospitalType");
        final hospitalTypeData = hospitalTypeDataList;
        for (var element in hospitalTypeData) {
          hospitalTypeList.add(element.hospitalTypeName.toString());
        }
        print("HospitalTypeBlocList:::$hospitalTypeList");
        emit(HospitalTypeSuccess(
            data: hospitalTypeList, selectedValue: selectedType));
      } catch (e) {
        emit(HospitalTypeFailed(error: e.toString()));
      }
    });

    on<SelectedHospitalTypeEvent>((event, emit) {
      selectedType = event.hospitalType;
      emit(HospitalTypeSuccess(
          data: hospitalTypeList, selectedValue: selectedType));
    });
  }
}
