part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpButtonPressed extends SignUpEvent {
  final String hospitalName;
  final String hospitalType;
  final String hospitalDept;
  final String designation;
  final String name;
  final String email;
  final String mobileNumber;
  final String password;
  final bool isChecked;

  SignUpButtonPressed(
      {required this.hospitalName,
      required this.hospitalType,
      required this.hospitalDept,
      required this.designation,
      required this.name,
      required this.email,
      required this.mobileNumber,
      required this.password,
      required this.isChecked});
}
