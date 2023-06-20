import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/data/model/hospital_dept/hospital_department.dart';

import '../../../../data/repository/sign_up/hospital_dept/hospital_department_repo.dart';

part 'hospital_department_event.dart';

part 'hospital_department_state.dart';

class HospitalDepartmentBloc
    extends Bloc<HospitalDepartmentEvent, HospitalDepartmentState> {
  final HospitalDepartmentRepository repository;

  List<HospitalDepartmentData> departmentData = [];
  List<String> departmentList = [];
  String selectedValue = "Select Department";
  HospitalDepartmentBloc({required this.repository})
      : super(HospitalDepartmentInitial()) {
    on<FetchHospitalDepartmentEvent>((event, emit) async {
      emit(HospitalDepartmentLoading());
      try {
        departmentData = await repository.getHospitalDepartment();
        departmentList.clear();
        departmentList.add("Select Department");
        for (var element in departmentData) {
          departmentList.add(element.departmentName.toString());
        }
        emit(HospitalDepartmentLoaded(
            selectedValue: selectedValue, data: departmentList));
        if (kDebugMode) {
          print("DepartmentBlocList$departmentList}");
        }
      } catch (e) {
        emit(HospitalDepartmentError(error: e.toString()));
      }
    });
    on<SelectedHospitalDepartmentEvent>((event, emit) {
      selectedValue = event.selectedDepartment;
      emit(HospitalDepartmentLoaded(
          selectedValue: selectedValue, data: departmentList));
    });
  }
}
