part of 'hospital_type_bloc.dart';

@immutable
abstract class HospitalTypeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HospitalTypeInitial extends HospitalTypeState {}

class HospitalTypeLoading extends HospitalTypeState{}

class HospitalTypeSuccess extends HospitalTypeState {
  final List<String> data;
  final String selectedValue;

   HospitalTypeSuccess({required this.data, required this.selectedValue});

  @override
  // TODO: implement props
  List<Object?> get props => [data, selectedValue];
}

class HospitalTypeFailed extends HospitalTypeState {
  final String error;

   HospitalTypeFailed({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

