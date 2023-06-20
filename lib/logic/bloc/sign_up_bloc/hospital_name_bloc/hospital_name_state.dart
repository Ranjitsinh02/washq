part of 'hospital_name_bloc.dart';

abstract class HospitalNameState extends Equatable {
  const HospitalNameState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HospitalNameInitial extends HospitalNameState {
  const HospitalNameInitial();
}

class HospitalNameLoading extends HospitalNameState {}

class HospitalNameSuccess extends HospitalNameState {
  final List<String> data;
  final String selectedValue;

   const HospitalNameSuccess({required this.data, required this.selectedValue});

  @override
  // TODO: implement props
  List<Object?> get props => [data, selectedValue];
}

class HospitalNameFailed extends HospitalNameState {
  final String error;

  const HospitalNameFailed({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
