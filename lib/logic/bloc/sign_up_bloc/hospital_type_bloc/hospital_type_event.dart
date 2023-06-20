part of 'hospital_type_bloc.dart';

@immutable
abstract class HospitalTypeEvent extends Equatable {
  const HospitalTypeEvent();

  @override
  List<Object> get props => [];
}

class FetchHospitalTypeEvent extends HospitalTypeEvent {}

class SelectedHospitalTypeEvent extends HospitalTypeEvent {
  final String hospitalType;

  const SelectedHospitalTypeEvent({required this.hospitalType});

  @override
  List<Object> get props => [hospitalType];
}
