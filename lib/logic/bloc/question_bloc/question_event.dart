part of 'question_bloc.dart';

@immutable
abstract class QuestionEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchQuestion extends QuestionEvent {}

class SectionStartButtonPressed extends QuestionEvent {
  final String hospitalId;

  // final String hospitalType;

  SectionStartButtonPressed({
    required this.hospitalId,
    /*required this.hospitalType*/
  });

  @override
  // TODO: implement props
  List<Object?> get props => [hospitalId];
}

class SaveAnswerButtonPressed extends QuestionEvent {
  final Map<int, bool?> answers;
  final QuestionData questionData;

  SaveAnswerButtonPressed({
    required this.answers,
    required this.questionData,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [answers, questionData];
}
