part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final List<UserProfileData> userProfileData;

  ProfileLoadSuccess({required this.userProfileData});

  @override
  List<Object?> get props => [userProfileData];
}

class ProfileFailed extends ProfileState {
  final String error;

  ProfileFailed({required this.error});
}
