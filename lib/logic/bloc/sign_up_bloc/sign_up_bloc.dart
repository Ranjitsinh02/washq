import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:washq/data/repository/sign_up/sign_up.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository repository;

  SignUpBloc({required this.repository}) : super(SignUpInitial()) {
    StreamedResponse response;
    on<SignUpButtonPressed>((event, emit) async {
      emit(SignUpLoading());
      try {
        Map<String, String> fieldData = {
          "name": event.name,
          "email": event.email,
          "password": event.password,
          "passconf": event.password,
          "mobile_no": event.mobileNumber,
          "terms_condition": event.isChecked ? "1" : "0",
          "hospital": event.hospitalName,
          "hospital_type": event.hospitalType,
          "hospital_department": event.hospitalDept,
          "hospital_designation": event.designation,
        };
        response = await repository.getResponse(fieldData);
        print("SignUpRespoes:: $response");
        if (response.statusCode == 200) {
          emit(SignUpSuccess());
        }
      } catch (error) {
        emit(SignUpFailure(error: error.toString()));
      }

      // TODO: implement event handler
    });
  }
}
