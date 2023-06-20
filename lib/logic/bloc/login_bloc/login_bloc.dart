import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_helper.dart';

import '../../../data/repository/login_repository/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  // String token = '';
  String otp = '';
  String data = '';
  String message = '';
  String emailID = '';

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginButtonOnPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        Map<String, dynamic> body = {
          "email": event.emailId,
          "password": event.password
        };
        final response = await loginRepository.loginRequest(body);
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
         String token = responseData["token"];
          message = responseData["message"];

          if (token.isNotEmpty) {
            AppHelper.setToken(token);
            AppHelper.setUserLoginStatus(true);
            emit(LoginSuccess(token: token));
          } else {
            emit(LoginFailed(message));
          }
        } else if (response.statusCode == 400) {
          throw "Please enter valid email or password!";
        } else {
          throw LoginFailed(message);
        }
      } catch (error) {
        emit(LoginFailed(error.toString()));
      }
    });

    on<ForgotButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        Map<String, dynamic> body = {
          "email": event.emailId,
        };
        emailID = event.emailId;
        final response = await loginRepository.forgotPassword(body);
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          otp = responseData["otp"];

          if (otp.isNotEmpty) {
            emit(ForgotPasswordSuccess(otp: otp));
          } else {
            emit(LoginFailed(message));
          }
        } else if (response.statusCode == 400) {
          throw "Please enter valid otp!";
        } else {
          throw LoginFailed(message);
        }
      } catch (e) {
        LoginFailed(e.toString());
      }
    });

    on<VerifyButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        Map<String, dynamic> body = {
          "otp": event.verifyOtp,
        };
        final response = await loginRepository.verifyOtp(body);
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);

          emit(VerifyOtpSuccess());
        } else if (response.statusCode == 400) {
          throw "Please enter valid email!";
        } else {
          throw LoginFailed(message);
        }
      } catch (e) {
        LoginFailed(e.toString());
      }
    });

    on<ResetConfirmButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        Map<String, dynamic> body = {
          "email": emailID,
          "password": event.password,
          "passconf": event.confirmPassword,
        };
        final response = await loginRepository.resetPassword(body);
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);

          print(responseData["message"].toString());
          if (responseData["message"] != null) {
            final message = responseData["message"];
            emit(ResetPasswordSuccess(message: message));
          }
        } else if (response.statusCode == 400) {
          throw "Please enter valid password!";
        } else {
          throw LoginFailed(message);
        }
      } catch (e) {
        LoginFailed(e.toString());
      }
    });
  }
}
