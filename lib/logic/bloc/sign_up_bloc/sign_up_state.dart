part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable {}

class SignUpInitial extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpSuccess extends SignUpState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
