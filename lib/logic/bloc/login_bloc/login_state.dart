part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({required this.token});

  @override
  // TODO: implement props
  List<Object?> get props => [token];
}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class ForgotPasswordSuccess extends LoginState {
  final String otp;

  ForgotPasswordSuccess({required this.otp});

  @override
  // TODO: implement props
  List<Object?> get props => [otp];
}

class VerifyOtpSuccess extends LoginState {}

class ResendCodeSuccess extends LoginState {}

class ResetPasswordSuccess extends LoginState {
  final String message;

  ResetPasswordSuccess({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
