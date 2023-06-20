part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class FetchHomeData extends HomeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnSubmitQuestionAnswer extends HomeEvent {
  final String hospitalId;
  final String hospitalDepartment;
  final Object? questionAnswer;

  OnSubmitQuestionAnswer({
    required this.questionAnswer,
    required this.hospitalId,
    required this.hospitalDepartment,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [questionAnswer, hospitalId, hospitalDepartment];
}
