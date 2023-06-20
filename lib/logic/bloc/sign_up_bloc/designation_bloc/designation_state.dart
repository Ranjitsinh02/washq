

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DesignationState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DesignationInitial extends DesignationState {}

class DesignationLoading extends DesignationState {}

class DesignationLoaded extends DesignationState {
  final String selectedValue;
  List<String> data;

  DesignationLoaded({required this.selectedValue, required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [data, selectedValue];
}

class DesignationError extends DesignationState {
  final String error;

  DesignationError({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
