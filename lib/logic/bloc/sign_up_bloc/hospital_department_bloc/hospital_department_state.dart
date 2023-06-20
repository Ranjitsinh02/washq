part of 'hospital_department_bloc.dart';

@immutable
abstract class HospitalDepartmentState extends Equatable {
  const HospitalDepartmentState();

  @override
  List<Object> get props => [];
}

class HospitalDepartmentInitial extends HospitalDepartmentState {}

class HospitalDepartmentLoading extends HospitalDepartmentState {}

class HospitalDepartmentLoaded extends HospitalDepartmentState {
  final String selectedValue;
  final List<String> data;

  const HospitalDepartmentLoaded(
      {required this.selectedValue, required this.data});

  @override
  List<Object> get props => [selectedValue, data];
}

class HospitalDepartmentError extends HospitalDepartmentState {
  final String error;

  const HospitalDepartmentError({required this.error});
}
