part of 'question_bloc.dart';

@immutable
abstract class QuestionState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class QuestionLoaded extends QuestionState {
  final QuestionModel questionModel;

  QuestionLoaded({required this.questionModel});

  @override
  List<Object?> get props => [questionModel];
}

class QuestionError extends QuestionState {
  final String error;

  QuestionError({required this.error});

  @override
  List<Object?> get props => [error];
}

class SaveButtonState extends QuestionState {
  final List<Map<String, bool>> answers;
  final QuestionData questionData;

  SaveButtonState({required this.answers, required this.questionData});

  @override
  List<Object?> get props => [answers, questionData];
}
