part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonOnPressed extends LoginEvent {
  final String emailId;
  final String password;

  LoginButtonOnPressed({required this.emailId, required this.password});
}

class ForgotButtonPressed extends LoginEvent {
  final String emailId;

  ForgotButtonPressed({required this.emailId});
}

class VerifyButtonPressed extends LoginEvent {
  final String verifyOtp;

  VerifyButtonPressed({required this.verifyOtp});
}

class ResendCodeButtonPressed extends LoginEvent {}

class ResetConfirmButtonPressed extends LoginEvent {
  final String password;
  final String confirmPassword;

  ResetConfirmButtonPressed(
      {
      required this.password,
      required this.confirmPassword});
}
