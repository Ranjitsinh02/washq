part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<SectionData> data;

  HomeLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});

  @override
  List<Object?> get props => [error];
}
