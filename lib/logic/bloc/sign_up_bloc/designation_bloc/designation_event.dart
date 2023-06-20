part of 'designation_bloc.dart';

@immutable
abstract class DesignationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDesignationEvent extends DesignationEvent{}

class SelectedDesignationValueEvent extends DesignationEvent{
  final String selectedDesignation;

  SelectedDesignationValueEvent({required this.selectedDesignation});

  @override
  List<Object> get props => [selectedDesignation];
}