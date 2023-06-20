import 'dart:convert';
import 'dart:convert' as convert;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washq/common_widget/app_helper.dart';
import 'package:washq/data/model/user_profile_model/user_profile_model.dart';
import 'package:washq/data/repository/user_profile/user_profile_repo.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserProfileRepo profileRepo;
  final List<UserProfileData> userProfileData = [];
  String hospitalId = '';
  String hospitalDepartment = '';

  ProfileBloc({required this.profileRepo}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is FetchUserDetails) {
        emit(ProfileLoading());
        try {
          String token = await AppHelper.getToken();
          final response = await profileRepo.getUserProfile(token);
          if (response.statusCode == 200) {
            var convertDartToJson =
                await convert.jsonDecode(utf8.decode(response.bodyBytes));
            UserProfileModel model =
                UserProfileModel.fromJson(convertDartToJson);
            print("Model:::::${jsonEncode(model)}");
            model.data?.forEach((element) {
              userProfileData.add(element);
            });
            if(userProfileData.isNotEmpty){
              for (var element in userProfileData) {
                hospitalId = element.userHospital ?? "";
                hospitalDepartment = element.userHospitalDepartment ?? "";
              }
            }
            emit(ProfileLoadSuccess(userProfileData: userProfileData));
          }
        } catch (e) {
          emit(ProfileFailed(error: e.toString()));
        }
      }
    });
  }
}
