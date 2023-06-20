import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/data/model/designation/designation_model.dart';

import '../../../../data/repository/sign_up/designation_repo/designation_repo.dart';
import 'designation_state.dart';

part 'designation_event.dart';

class DesignationBloc extends Bloc<DesignationEvent, DesignationState> {
  final DesignationRepository repository;
  List<DesignationData> designationData = [];
  List<String> designationList = [];

  String selectedValue = "Designation";

  DesignationBloc({required this.repository}) : super(DesignationInitial()) {
    on<FetchDesignationEvent>((event, emit) async {
      emit(DesignationLoading());
      try {
        designationData = await repository.getDesignation();
        designationList.clear();
        designationList.add("Designation");
        for (var element in designationData) {
          designationList.add(element.designationName.toString());
        }
        emit(DesignationLoaded(
            selectedValue: selectedValue, data: designationList));
      } catch (e) {
        emit(DesignationError(error: e.toString()));
      }
    });

    on<SelectedDesignationValueEvent>((event, emit) {
      selectedValue = event.selectedDesignation;
      emit(DesignationLoaded(
          selectedValue: selectedValue, data: designationList));
    });
  }
}
