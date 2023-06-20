

import 'package:equatable/equatable.dart';


abstract class HospitalNameEvent extends Equatable{
  const HospitalNameEvent();

  @override
  List<Object> get props => [];
}

class FetchHospitalName extends HospitalNameEvent{}

class SelectHospitalNameValue extends HospitalNameEvent {
  final String hospitalName;


  const SelectHospitalNameValue({required this.hospitalName});

  @override
  List<Object> get props => [hospitalName];
}
