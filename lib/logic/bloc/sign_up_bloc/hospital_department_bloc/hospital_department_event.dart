part of 'hospital_department_bloc.dart';

@immutable
abstract class HospitalDepartmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchHospitalDepartmentEvent extends HospitalDepartmentEvent {}

class SelectedHospitalDepartmentEvent extends HospitalDepartmentEvent {
  final String selectedDepartment;

  SelectedHospitalDepartmentEvent({required this.selectedDepartment});

  @override
  List<Object> get props => [selectedDepartment];
}
